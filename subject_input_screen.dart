import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubjectInputScreen extends StatefulWidget {
  const SubjectInputScreen({super.key});

  @override
  State<SubjectInputScreen> createState() => _SubjectInputScreenState();
}

class _SubjectInputScreenState extends State<SubjectInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController semesterNoController = TextEditingController();
  final TextEditingController creditHoursController = TextEditingController();
  final TextEditingController marksController = TextEditingController();

  Future<void> submitData() async {
    if (_formKey.currentState!.validate()) {
      final uri = Uri.parse("https://devtechtop.com/management/public/api/grades");

      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "user_id": userIdController.text,
          "course_name": courseNameController.text,
          "semester_no": semesterNoController.text,
          "credit_hours": creditHoursController.text,
          "marks": marksController.text,
        }),
      );

      final resData = json.decode(response.body);

      if (response.statusCode == 200 && resData["message"] != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("✅ Data submitted successfully!"),
        ));
        _formKey.currentState!.reset();
      } else if (resData['errors'] != null) {
        String errorMsg = resData['errors'].entries
            .map((e) => "${e.key}: ${e.value.join(', ')}")
            .join("\n");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("❌ Errors:\n$errorMsg"),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("❌ Something went wrong"),
        ));
      }

      print("Status: ${response.statusCode}");
      print("Response: ${response.body}");
    }
  }

  Widget buildInputField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        validator: (value) => value!.isEmpty ? 'Required' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Subject Data"),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.pushNamed(context, '/list');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter Course Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              buildInputField(userIdController, 'User ID'),
              buildInputField(courseNameController, 'Course Title'),
              buildInputField(semesterNoController, 'Semester Number'),
              buildInputField(creditHoursController, 'Credit Hours'),
              buildInputField(marksController, 'Marks Obtained'),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: submitData,
                icon: const Icon(Icons.send),
                label: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
