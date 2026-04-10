// Importa widgets básicos de Flutter (UI)
import 'package:flutter/material.dart';

// Permite acceder a la cámara o galería
import 'package:image_picker/image_picker.dart';

// Manejo de estado global
import 'package:provider/provider.dart';

// Generador de IDs únicos
import 'package:uuid/uuid.dart';

// Permite hacer vibrar el dispositivo
import 'package:vibration/vibration.dart';

// Importa el provider (gestiona la lista de ropa)
import '../providers/wardrobe_provider.dart';

// Importa el modelo de datos de una prenda
import '../models/clothing_item.dart';

/// Pantalla principal que permite tomar fotos o seleccionar imágenes
class CameraScreen extends StatelessWidget {
  // Instancia de ImagePicker para acceder a cámara o galería
  final ImagePicker _picker = ImagePicker();

  // Generador de IDs únicos para cada prenda
  final Uuid uuid = Uuid();

  // Constructor
  CameraScreen({super.key});

  /// Método para tomar una foto con la cámara
  Future<void> _takePhoto(BuildContext context) async {
    // Abre la cámara
    final image = await _picker.pickImage(source: ImageSource.camera);

    // Si el usuario cancela, no hace nada
    if (image == null) return;

    // Crea un nuevo objeto ClothingItem con ID único y ruta de imagen
    final newItem = ClothingItem(
      id: uuid.v4(),
      imagePath: image.path,
    );

    // Agrega la prenda al provider (estado global)
    Provider.of<WardrobeProvider>(context, listen: false)
        .addClothing(newItem);

    // Si el dispositivo tiene vibración, vibra por 100 ms
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100);
    }
  }

  /// Método para seleccionar una imagen desde la galería
  Future<void> _pickFromGallery(BuildContext context) async {
    // Abre la galería
    final image = await _picker.pickImage(source: ImageSource.gallery);

    // Si el usuario cancela, no hace nada
    if (image == null) return;

    // Crea un nuevo objeto ClothingItem
    final newItem = ClothingItem(
      id: uuid.v4(),
      imagePath: image.path,
    );
  
    // Guarda la prenda en el provider
    Provider.of<WardrobeProvider>(context, listen: false)
        .addClothing(newItem);

    // Vibra para dar feedback al usuario
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100);
    }
  }

  /// Construcción de la interfaz de usuario
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior con título
      appBar: AppBar(title: const Text("Cámara")),

      // Cuerpo centrado
      body: Center(
        child: Column(
          // Centra los elementos verticalmente
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Botón para tomar foto
            ElevatedButton(
              onPressed: () => _takePhoto(context),
              child: const Text("Tomar foto"),
            ),

            // Botón para abrir galería
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