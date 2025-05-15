import 'package:flutter/material.dart';
import 'db_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Example',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _records = [];

  @override
  void initState() {
    super.initState();
    _loadTexts();
  }

  Future<void> _loadTexts() async {
    final data = await DBHelper().getTexts();
    setState(() {
      _records = data;
    });
  }

  Future<void> _saveText() async {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      await DBHelper().insertText(text);
      _controller.clear();
      _loadTexts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Save to SQLite')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter text',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity, // Button takes full width
                child: ElevatedButton(
                  onPressed: _saveText,
                  child: Text('Save'),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: _records.isEmpty
                    ? Center(child: Text('No records found.'))
                    : ListView.builder(
                  itemCount: _records.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(_records[index]['content']),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
