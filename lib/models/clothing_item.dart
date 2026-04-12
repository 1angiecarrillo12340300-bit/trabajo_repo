/// Modelo que representa una prenda de ropa dentro de la aplicación
class ClothingItem {
  /// Identificador único de la prenda
  /// Se genera normalmente con UUID para evitar duplicados
  final String id;

  /// Nombre de la prenda
  /// Puede ser asignado por el usuario o generado automáticamente
  final String? name;

  /// Ruta de la imagen en el dispositivo
  /// Indica dónde está almacenada la foto de la prenda
  final String imagePath;

  /// Constructor de la clase ClothingItem
  ///
  /// [id]: identificador único de la prenda
  /// [imagePath]: ruta local de la imagen capturada o seleccionada
  /// [name]: nombre opcional de la prenda
  ClothingItem({required this.id, required this.imagePath, this.name});

  /// Convierte el objeto a un mapa JSON
  /// Útil para guardar en almacenamiento local o enviar por red
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'imagePath': imagePath};
  }

  /// Crea un objeto ClothingItem desde un mapa JSON
  /// Útil para cargar datos desde almacenamiento local o recibir por red
  factory ClothingItem.fromJson(Map<String, dynamic> json) {
    return ClothingItem(
      id: json['id'] as String,
      name: json['name'] as String?,
      imagePath: json['imagePath'] as String,
    );
  }
}
