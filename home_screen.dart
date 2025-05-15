import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  // Dummy subject data
  final List<Map<String, String>> subjects = [
    {
      'subject': 'Mathematics',
      'teacher': 'Dr. Khan',
      'credits': '3',
    },
    {
      'subject': 'Computer Science',
      'teacher': 'Miss Ayesha',
      'credits': '4',
    },
    {
      'subject': 'Physics',
      'teacher': 'Sir Ahmed',
      'credits': '3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Subjects'),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text(
                'Welcome!',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            // Add more drawer options if needed
          ],
        ),
      ),
      body: Column(
        children: [
          Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/Flag_of_Pakistan.svg/320px-Flag_of_Pakistan.svg.png',
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          Text(
            'Enrolled Subjects',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subject = subjects[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(subject['subject']!),
                    subtitle: Text('Teacher: ${subject['teacher']}'),
                    trailing: Text('${subject['credits']} CH'),
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
