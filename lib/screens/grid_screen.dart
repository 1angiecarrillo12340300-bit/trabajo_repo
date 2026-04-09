import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wardrobe_provider.dart';
import '../widgets/clothing_card.dart';

class GridScreen extends StatelessWidget {
  const GridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WardrobeProvider>(context);
    final clothes = provider.clothes;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi guardarropa"),
      ),
      body: clothes.isEmpty
          ? const Center(child: Text("No hay prendas aún"))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: clothes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final item = clothes[index];
                return ClothingCard(item: item);
              },
            ),
    );
  }
}