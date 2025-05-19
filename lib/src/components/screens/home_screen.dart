import 'package:flutter/material.dart';

class DSHomeScreen extends StatefulWidget {
  const DSHomeScreen({super.key});

  @override
  State<DSHomeScreen> createState() => _DSHomeScreenState();
}

class _DSHomeScreenState extends State<DSHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Home Screen'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
