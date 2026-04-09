import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';

import '../providers/wardrobe_provider.dart';
import '../models/clothing_item.dart';

class CameraScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  final Uuid uuid = Uuid();

  CameraScreen({super.key});

  Future<void> _takePhoto(BuildContext context) async {
    final image = await _picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    final newItem = ClothingItem(
      id: uuid.v4(),
      imagePath: image.path,
    );

    Provider.of<WardrobeProvider>(context, listen: false)
        .addClothing(newItem);

    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100);
    }
  }

  Future<void> _pickFromGallery(BuildContext context) async {
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    final newItem = ClothingItem(
      id: uuid.v4(),
      imagePath: image.path,
    );
  
    Provider.of<WardrobeProvider>(context, listen: false)
        .addClothing(newItem);

    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cámara")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _takePhoto(context),
              child: const Text("Tomar foto"),
            ),
            ElevatedButton(
              onPressed: () => _pickFromGallery(context),
              child: const Text("Galería"),
            ),
          ],
        ),
      ),
    );
  }
}