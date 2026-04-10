/// Modelo que representa una prenda de ropa dentro de la aplicación
class ClothingItem {
  /// Identificador único de la prenda
  /// Se genera normalmente con UUID para evitar duplicados
  final String id;

  /// Ruta de la imagen en el dispositivo
  /// Indica dónde está almacenada la foto de la prenda
  final String imagePath;

  /// Constructor de la clase ClothingItem
  /// 
  /// [id]: identificador único de la prenda
  /// [imagePath]: ruta local de la imagen capturada o seleccionada
  ClothingItem({
    required this.id,
    required this.imagePath,
  });
}