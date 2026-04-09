import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/wardrobe_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WardrobeProvider()..loadClothes(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StyleStack',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WardrobeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Guardarropa'),
      ),
      body: ListView.builder(
        itemCount: provider.clothes.length,
        itemBuilder: (context, index) {
          final item = provider.clothes[index];
          return ListTile(
            title: Text(item.name),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<WardrobeProvider>(context, listen: false)
              .addClothing("Camisa", "ruta_imagen");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}