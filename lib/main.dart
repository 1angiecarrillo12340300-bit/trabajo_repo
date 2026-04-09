import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/wardrobe_provider.dart';
import 'screens/camera_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WardrobeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CameraScreen(),
    );
  }
}