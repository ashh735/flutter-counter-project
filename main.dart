import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'bgnu_map_screen.dart';
import 'search_map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/bgnu': (context) => BGNUMapScreen(),
        '/search': (context) => SearchMapScreen(),
      },
    );
  }
}
