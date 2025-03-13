import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [StudentDataScreen(), CalculatorScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Data & Calculator')),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.table_chart), label: 'Students'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Calculator'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class StudentDataScreen extends StatelessWidget {
  final List<Map<String, String>> students = [
    {'ID': '1', 'Name': 'Ayesha', 'Grade': 'A'},
    {'ID': '2', 'Name': 'Alishba', 'Grade': 'B+'},
    {'ID': '3', 'Name': 'Anum', 'Grade': 'A-'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('Student Data', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          DataTable(
            columns: [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Grade')),
            ],
            rows: students.map((student) {
              return DataRow(cells: [
                DataCell(Text(student['ID']!)),
                DataCell(Text(student['Name']!)),
                DataCell(Text(student['Grade']!)),
              ]);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String _output = "";
  double num1 = 0;
  double num2 = 0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "=") {
      num2 = double.parse(_output);
      if (operand == "+") {
        _output = (num1 + num2).toString();
      } else if (operand == "-") {
        _output = (num1 - num2).toString();
      } else if (operand == "*") {
        _output = (num1 * num2).toString();
      } else if (operand == "/") {
        _output = (num1 / num2).toString();
      }
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
      num1 = double.parse(_output);
      operand = buttonText;
      _output = "";
    } else {
      _output = _output + buttonText;
    }
    setState(() {
      output = _output;
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(buttonText, style: TextStyle(fontSize: 20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          child: Text(output, style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Column(
            children: [
              Row(children: [buildButton("7"), buildButton("8"), buildButton("9"), buildButton("/")]),
              Row(children: [buildButton("4"), buildButton("5"), buildButton("6"), buildButton("*")]),
              Row(children: [buildButton("1"), buildButton("2"), buildButton("3"), buildButton("-")]),
              Row(children: [buildButton("C"), buildButton("0"), buildButton("="), buildButton("+")]),
            ],
          ),
        ),
      ],
    );
  }
}
