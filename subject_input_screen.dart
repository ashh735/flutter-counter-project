import 'package:flutter/material.dart';
import 'db_helper.dart';

class SubjectInputScreen extends StatefulWidget {
  const SubjectInputScreen({super.key});

  @override
  _SubjectInputScreenState createState() => _SubjectInputScreenState();
}

class _SubjectInputScreenState extends State<SubjectInputScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedCourse;
  double? selectedCreditHour;
  int? selectedSemester;
  TextEditingController marksController = TextEditingController();

  List<String> csCourses = ['OOP', 'DBMS', 'DSA', 'CN', 'AI'];
  List<double> creditHours = [0, 1, 1.5, 2, 4];
  List<int> semesters = List.generate(8, (index) => index + 1);

  void submitData() async {
    if (_formKey.currentState!.validate() &&
        selectedCourse != null &&
        selectedCreditHour != null &&
        selectedSemester != null) {
      await DBHelper.insertData({
        'subjectName': selectedCourse,
        'course': selectedCourse,
        'marks': int.parse(marksController.text),
        'creditHour': selectedCreditHour,
        'semester': selectedSemester
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data Save Ho Gaya')),
      );

      // Optional: Clear fields after save
      setState(() {
        selectedCourse = null;
        selectedCreditHour = null;
        selectedSemester = null;
        marksController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subject Entry')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Select Course'),
                value: selectedCourse,
                items: csCourses.map((course) {
                  return DropdownMenuItem(value: course, child: Text(course));
                }).toList(),
                onChanged: (value) => setState(() => selectedCourse = value),
              ),
              TextFormField(
                controller: marksController,
                decoration: InputDecoration(labelText: 'Marks'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? 'Marks Daalain' : null,
              ),
              DropdownButtonFormField<double>(
                decoration: InputDecoration(labelText: 'Credit Hour'),
                value: selectedCreditHour,
                items: creditHours.map((hour) {
                  return DropdownMenuItem(value: hour, child: Text('$hour'));
                }).toList(),
                onChanged: (value) =>
                    setState(() => selectedCreditHour = value),
              ),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(labelText: 'Semester'),
                value: selectedSemester,
                items: semesters.map((sem) {
                  return DropdownMenuItem(value: sem, child: Text('$sem'));
                }).toList(),
                onChanged: (value) =>
                    setState(() => selectedSemester = value),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitData,
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
