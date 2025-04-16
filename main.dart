import 'package:flutter/material.dart';
import 'qr_scanner_screen.dart';
import 'qr_generator_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
    routes: {
      '/scan': (context) => QRScannerScreen(),
      '/generate': (context) => QRGeneratorScreen(),
    },
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Scan QR Code'),
              onPressed: () => Navigator.pushNamed(context, '/scan'),
            ),
            ElevatedButton(
              child: Text('Generate QR Code'),
              onPressed: () => Navigator.pushNamed(context, '/generate'),
            ),
          ],
        ),
      ),
    );
  }
}
