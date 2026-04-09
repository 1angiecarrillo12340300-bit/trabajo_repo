import 'dart:io';
import 'package:flutter/material.dart';
import '../models/clothing_item.dart';

class ClothingCard extends StatelessWidget {
  final ClothingItem item;

  const ClothingCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.file(
              File(item.imagePath),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}