 import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multi Screen App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _navButton(context, 'Screen 1 - Ayesha Riyasat', NameScreen()),
            _navButton(context, 'Screen 2 - Button', ButtonScreen()),
            _navButton(context, 'Screen 3 - Name & Button', NameButtonScreen()),
            _navButton(context, 'Screen 4 - Friends List', FriendsScreen()),
          ],
        ),
      ),
    );
  }

  Widget _navButton(BuildContext context, String title, Widget screen) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => screen)),
        child: Text(title),
      ),
    );
  }
}

// 1st Screen: Show Name
class NameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Name')),
      body: Center(
        child: Text('Ayesha Riyasat', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

// 2nd Screen: Show Elevated Button
class ButtonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Elevated Button')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Click Me'),
        ),
      ),
    );
  }
}

// 3rd Screen: Show Name & Button
class NameButtonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Name& Button')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ayesha Riyasat', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Click Me'),
            ),
          ],
        ),
      ),
    );
  }
}

// 4th Screen: Show Friend List with Button Click
class FriendsScreen extends StatefulWidget {
  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  List<String> friends = ['Aiza', 'Anum', 'Aliza', 'Alishba', 'Ayesha'];
  int currentIndex = 0;

  void showNextFriend() {
    setState(() {
      if (currentIndex < friends.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0; // Reset to first friend after last
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Friend List')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              friends[currentIndex],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: showNextFriend,
              child: Text('Show Next Friend'),
            ),
          ],
        ),
      ),
    );
  }
}
