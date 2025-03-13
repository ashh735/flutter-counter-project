 import 'package:flutter/material.dart';

void main() {
  runApp(const MyHomePageState());
}

class MyHomePageState extends StatelessWidget {
  const MyHomePageState({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/l.jpeg', // replace with your logo image
              height: 30,
              width: 30,
            ),
            const SizedBox(width: 10),
            const Text('BGNU'),
          ],
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'About Baba Guru Nanak University',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Baba Guru Nanak University is a public sector university located in District Nankana Sahib, in the Punjab region of Pakistan.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/j.jpeg', // replace with your image
                height: 200,
                width: 200,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 50,
          child: Center(
            child: Text(
              'OK',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
