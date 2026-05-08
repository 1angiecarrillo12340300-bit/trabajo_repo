import 'package:flutter/material.dart';
import 'grid_screen.dart';
import 'camera_screen.dart';
import 'suggestions_screen.dart';
import 'map_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const GridScreen(),
    const CameraScreen(),
    const SuggestionsScreen(),
    const MapScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: "Cámara",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: "Sugerencias",
          ),
          BottomNavigationBarItem( // ✅ NUEVO
            icon: Icon(Icons.map),
            label: "Mapa",
          ),
        ],
      ),
    );
  }
}