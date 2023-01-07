import 'package:flutter/material.dart';
import 'package:zigy/views/screen1.dart';
import 'package:zigy/views/screen2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _currentIndex;
  late List<Widget> _screens;

  @override
  void initState() {
    _currentIndex = 0;
    _screens = const [
      Screen1(),
      Screen2(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Page",
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.post_add),
                label: "Posts",
                backgroundColor: Colors.amber),
          ]),
    );
  }
}
