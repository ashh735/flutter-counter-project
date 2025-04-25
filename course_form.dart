import 'package:flutter/material.dart';
import 'course_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CourseFormScreen extends StatefulWidget {
  @override
  _CourseFormScreenState createState() => _CourseFormScreenState();
}

class _CourseFormScreenState extends State<CourseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? userId;
  Course? selectedCourse;
  String? marks;
  int? selectedCreditHour;
  int? selectedSemester;
  List<Course> courseList = [];
  List<Map<String, dynamic>> submittedCourses = [];

  @override
  void initState() {
    super.initState();
    fetchCourses();
    loadLocalData();
  }

  Future<void> fetchCourses() async {
    final url = 'https://bgnuerp.online/api/get_courses?user_id=12122';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List decoded = json.decode(response.body);
      setState(() {
        courseList = decoded.map((e) => Course.fromJson(e)).toList();
      });
    }
  }

  Future<void> saveLocally() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final prefs = await SharedPreferences.getInstance();

      submittedCourses.add({
        "user_id": userId,
        "course": selectedCourse?.toJson(),
        "marks": marks,
        "credit_hour": selectedCreditHour,
        "semester": selectedSemester,
      });

      await prefs.setString('saved_courses', json.encode(submittedCourses));
      setState(() {});
    }
  }

  Future<void> loadLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('saved_courses');
    if (data != null) {
      submittedCourses = List<Map<String, dynamic>>.from(json.decode(data));
      setState(() {});
    }
  }

  Future<void> submitToAPI() async {
    for (var course in submittedCourses) {
      await http.post(
        Uri.parse('https://devtechtop.com/management/public/api/grades'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(course),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Data successfully entered into API'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      appBar: AppBar(
        title: const Text("📘 My Course Form"),
        backgroundColor: const Color(0xFF4E3E7E),
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text("Enter Course Info", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF4E3E7E))),
                const SizedBox(height: 20),
                buildInputField(
                  label: "User ID",
                  icon: Icons.person,
                  onSaved: (val) => userId = val,
                  validator: (val) => val == null || val.isEmpty ? "Enter user ID" : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<Course>(
                  decoration: inputDecoration(label: "Select Course", icon: Icons.book),
                  value: selectedCourse,
                  items: courseList
                      .map((course) => DropdownMenuItem(
                    value: course,
                    child: Text("${course.subjectCode} - ${course.subjectName}"),
                  ))
                      .toList(),
                  onChanged: (val) => setState(() => selectedCourse = val),
                  validator: (val) => val == null ? "Select a course" : null,
                ),
                const SizedBox(height: 16),
                buildInputField(
                  label: "Marks",
                  icon: Icons.score,
                  keyboardType: TextInputType.number,
                  onSaved: (val) => marks = val,
                  validator: (val) => val == null || val.isEmpty ? "Enter marks" : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  decoration: inputDecoration(label: "Credit Hour", icon: Icons.timelapse),
                  value: selectedCreditHour,
                  items: [1, 2, 3, 4]
                      .map((ch) => DropdownMenuItem(value: ch, child: Text("$ch")))
                      .toList(),
                  onChanged: (val) => setState(() => selectedCreditHour = val),
                  validator: (val) => val == null ? "Select credit hour" : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  decoration: inputDecoration(label: "Semester", icon: Icons.school),
                  value: selectedSemester,
                  items: List.generate(8, (i) => i + 1)
                      .map((sem) => DropdownMenuItem(value: sem, child: Text("Semester $sem")))
                      .toList(),
                  onChanged: (val) => setState(() => selectedSemester = val),
                  validator: (val) => val == null ? "Select semester" : null,
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: buttonStyle(const Color(0xFF7F56D9)),
                        onPressed: saveLocally,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.save_alt, color: Colors.white),
                            SizedBox(width: 10),
                            Text("Save Locally", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: buttonStyle(const Color(0xFF5C4D91)),
                        onPressed: submitToAPI,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.cloud_upload_outlined, color: Colors.white),
                            SizedBox(width: 10),
                            Text("Submit", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                const Divider(thickness: 1.2),
                const SizedBox(height: 10),
                const Text("Submitted Courses", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF4E3E7E))),
                const SizedBox(height: 12),
                ...submittedCourses.map((e) => Card(
                  color: const Color(0xFFF0ECFF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.check_circle_rounded, color: Color(0xFF7F56D9)),
                    title: Text(e['course']['subject_name'], style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text("Marks: ${e['marks']} | Credit: ${e['credit_hour']} | Sem: ${e['semester']}", style: const TextStyle(fontSize: 13)),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration({required String label, required IconData icon}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: const Color(0xFF5C4D91)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: const Color(0xFFF7F4FF),
    );
  }

  Widget buildInputField({
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      decoration: inputDecoration(label: label, icon: icon),
      keyboardType: keyboardType,
      onSaved: onSaved,
      validator: validator,
    );
  }

  ButtonStyle buttonStyle(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    );
  }
}
