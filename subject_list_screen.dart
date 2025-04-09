import 'package:flutter/material.dart';
import 'db_helper.dart';

class SubjectListScreen extends StatefulWidget {
  const SubjectListScreen({super.key});

  @override
  _SubjectListScreenState createState() => _SubjectListScreenState();
}

class _SubjectListScreenState extends State<SubjectListScreen> {
  List<Map<String, dynamic>> subjectList = [];

  void loadData() async {
    subjectList = await DBHelper.getData();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Saved Subjects')),
      body: ListView.builder(
        itemCount: subjectList.length,
        itemBuilder: (context, index) {
          final subject = subjectList[index];
          return ListTile(
            title: Text(subject['subjectName']),
            subtitle: Text(
              'Marks: ${subject['marks']} | Credit: ${subject['creditHour']} | Semester: ${subject['semester']}',
            ),
          );
        },
      ),
    );
  }
}
