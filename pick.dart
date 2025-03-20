 import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ScreenOne(),
    );
  }
}

// Screen 1: Vertical ListView
class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  final List<String> internetImages = const [
    'https://media.istockphoto.com/id/1443562748/photo/cute-ginger-cat.jpg?s=612x612&w=0&k=20&c=vvM97wWz-hMj7DLzfpYRmY2VswTqcFEKkC437hxm3Cg=',
    'https://images.squarespace-cdn.com/content/v1/607f89e638219e13eee71b1e/1684821560422-SD5V37BAG28BURTLIXUQ/michael-sum-LEpfefQf4rU-unsplash.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvOdPUHbYDaAt9uXDEkFIm94yxL0hl34NT2rQoON0FuPjwuBcBbTB9MT44wgFg1I4R5t0&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0IczyiZOLYsthb-MuPaV3b5OvcnJSIX0POqNldVGrvF3m1zu4Lmlodhen37X8IoY-ceo&usqp=CAU',
  ];

  final List<String> localImages = const [
    'assets/pick1.jpeg',
    'assets/pick2.jpeg',
    'assets/pick3.jpeg',
    'assets/pick4.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vertical ListView')),
      body: ListView(
        children: [
          ...internetImages.map((url) => Image.network(url, height: 150)).toList(),
          ...localImages.map((path) => Image.asset(path, height: 150)).toList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScreenTwo()),
        ),
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

// Screen 2: Horizontal ListView
class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  final List<String> internetImages = const [
    'https://media.istockphoto.com/id/1443562748/photo/cute-ginger-cat.jpg?s=612x612&w=0&k=20&c=vvM97wWz-hMj7DLzfpYRmY2VswTqcFEKkC437hxm3Cg=',
    'https://images.squarespace-cdn.com/content/v1/607f89e638219e13eee71b1e/1684821560422-SD5V37BAG28BURTLIXUQ/michael-sum-LEpfefQf4rU-unsplash.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvOdPUHbYDaAt9uXDEkFIm94yxL0hl34NT2rQoON0FuPjwuBcBbTB9MT44wgFg1I4R5t0&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0IczyiZOLYsthb-MuPaV3b5OvcnJSIX0POqNldVGrvF3m1zu4Lmlodhen37X8IoY-ceo&usqp=CAU',
  ];

  final List<String> localImages = const [
     'assets/pick1.jpeg',
    'assets/pick2.jpeg',
    'assets/pick3.jpeg',
    'assets/pick4.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Horizontal ListView')),
      body: SizedBox(
        height: 200,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ...internetImages.map((url) => Image.network(url, width: 150)).toList(),
            ...localImages.map((path) => Image.asset(path, width: 150)).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScreenThree()),
        ),
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

// Screen 3: GridView instead of ListView
class ScreenThree extends StatelessWidget {
  const ScreenThree({super.key});

  final List<String> internetImages = const [
    'https://media.istockphoto.com/id/1443562748/photo/cute-ginger-cat.jpg?s=612x612&w=0&k=20&c=vvM97wWz-hMj7DLzfpYRmY2VswTqcFEKkC437hxm3Cg=',
    'https://images.squarespace-cdn.com/content/v1/607f89e638219e13eee71b1e/1684821560422-SD5V37BAG28BURTLIXUQ/michael-sum-LEpfefQf4rU-unsplash.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvOdPUHbYDaAt9uXDEkFIm94yxL0hl34NT2rQoON0FuPjwuBcBbTB9MT44wgFg1I4R5t0&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0IczyiZOLYsthb-MuPaV3b5OvcnJSIX0POqNldVGrvF3m1zu4Lmlodhen37X8IoY-ceo&usqp=CAU',
  ];

  final List<String> localImages = const [
    'assets/pick1.jpeg',
    'assets/pick2.jpeg',
    'assets/pick3.jpeg',
    'assets/pick4.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GridView Example')),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          ...internetImages.map((url) => Image.network(url)).toList(),
          ...localImages.map((path) => Image.asset(path)).toList(),
        ],
      ),
    );
  }
}
