import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class GradeBookPage extends StatefulWidget {
  const GradeBookPage({super.key});

  @override
  GradeBookPageState createState() => GradeBookPageState();
}

class GradeBookPageState extends State<GradeBookPage> {
  List<dynamic> gradeData = [];

  Future<void> loadData() async {
    final response =
    await http.get(Uri.parse('https://bgnuerp.online/api/gradeapi'));

    if (response.statusCode == 200) {
      setState(() {
        gradeData = json.decode(response.body);
      });
    } else {
      // Error handling
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data')),
      );
    }
  }

  void eraseData() {
    setState(() {
      gradeData.clear();
    });
  }

  void deleteItem(int index) {
    setState(() {
      gradeData.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grade Book'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: loadData,
                child: Text('Load Data'),
              ),
              ElevatedButton(
                onPressed: eraseData,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Erase Data'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: gradeData.length,
              itemBuilder: (context, index) {
                final item = gradeData[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name: ${item['studentname']}"),
                        Text("Father Name: ${item['fathername']}"),
                        Text("Program: ${item['progname']}"),
                        Text("Shift: ${item['shift']}"),
                        Text("Roll No: ${item['rollno']}"),
                        Text("Course Code: ${item['coursecode']}"),
                        Text("Course Title: ${item['coursetitle']}"),
                        Text("Credit Hours: ${item['credithours']}"),
                        Text("Obtained Marks: ${item['obtainedmarks']}"),
                        Text("Semester: ${item['mysemester']}"),
                        Text("Status: ${item['consider_status']}"),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () => deleteItem(index),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            child: Text('Delete'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
