import 'package:flutter/material.dart';

void main() {
  runApp(PakistanFlagApp());
}

class PakistanFlagApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pakistan Flag App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FlagScreen()),
            );
          },
          child: Text('Show Pakistan Flag'),
        ),
      ),
    );
  }
}

class FlagScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pakistan Flag')),
      body: Center(
        child: Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/Flag_of_Pakistan.svg/320px-Flag_of_Pakistan.svg.png',
          width: 300,
          errorBuilder: (context, error, stackTrace) {
            return Text('Failed to load image');
          },
        ),
      ),
    );
  }
}
