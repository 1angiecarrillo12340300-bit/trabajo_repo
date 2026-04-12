import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  static final ImageService _instance = ImageService._internal();
  final ImagePicker _picker = ImagePicker();

  factory ImageService() {
    return _instance;
  }

  ImageService._internal();

  /// Captura una foto con la cámara
  /// (los permisos se solicitan automáticamente por image_picker)
  Future<File?> takePicture() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (photo == null) return null;

      // Guardar la foto en el directorio de documentos
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = 'photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImage = await File(photo.path).copy(
        '${appDir.path}/$fileName',
      );

      return savedImage;
    } catch (e) {
      throw Exception('Error al capturar foto: $e');
    }
  }

  /// Selecciona una foto de la galería
  /// (los permisos se solicitan automáticamente por image_picker)
  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image == null) return null;

      // Guardar la imagen en el directorio de documentos
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = 'photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImage = await File(image.path).copy(
        '${appDir.path}/$fileName',
      );

      return savedImage;
    } catch (e) {
      throw Exception('Error al seleccionar foto: $e');
    }
  }

  /// Obtiene el directorio para almacenar imágenes
  Future<Directory> getImagesDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final imagesDir = Directory('${appDir.path}/images');
    
    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }
    
    return imagesDir;
  }

  /// Obtiene la ruta de la imagen como String
  Future<String> getImagePath(File imageFile) async {
    return imageFile.path;
  }

  /// Elimina una imagen del almacenamiento
  Future<void> deleteImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      throw Exception('Error al eliminar imagen: $e');
    }
  }
}
