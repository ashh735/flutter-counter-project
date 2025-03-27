import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  late Database database;
  List<Map<String, dynamic>> subjects = [];
  String? selectedSubject;
  TextEditingController marksController = TextEditingController();

  List<String> subjectList = ['English', 'Math', 'Science', 'AI'];

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  Future<void> initDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'subjects.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE subjects(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, marks INTEGER)",
        );
      },
      version: 1,
    );
    fetchSubjects();
  }

  Future<void> insertSubject(String name, int marks) async {
    await database.insert('subjects', {'name': name, 'marks': marks});
    fetchSubjects();
  }

  Future<void> fetchSubjects() async {
    final List<Map<String, dynamic>> data = await database.query('subjects');
    setState(() {
      subjects = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedSubject,
              hint: Text('Select Subject'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedSubject = newValue;
                });
              },
              items: subjectList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: marksController,
              decoration: InputDecoration(labelText: 'Enter Marks'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (selectedSubject != null && marksController.text.isNotEmpty) {
                  insertSubject(selectedSubject!, int.parse(marksController.text));
                  marksController.clear();
                }
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${subjects[index]['name']}'),
                    subtitle: Text('Marks: ${subjects[index]['marks']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
