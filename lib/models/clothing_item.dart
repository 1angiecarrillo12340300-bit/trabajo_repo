class ClothingItem {
  final String id;
 HEAD

  /// Nombre de la prenda
  /// Puede ser asignado por el usuario o generado automáticamente
  final String? name;

  /// Ruta de la imagen en el dispositivo
  /// Indica dónde está almacenada la foto de la prenda

  final String name;
 6ec51dca6f4a8fdb8dc06ad281200c1322473e66
  final String imagePath;
  final String? category;
  final String? color;
  bool isFavorite;

HEAD
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

  ClothingItem({
    required this.id,
    required this.name,
    required this.imagePath,
    this.category,
    this.color,
    this.isFavorite = false,
  });

  // Convertir a JSON para almacenamiento
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
      'category': category,
      'color': color,
      'isFavorite': isFavorite,
    };
  }

  // Crear desde JSON
  factory ClothingItem.fromJson(Map<String, dynamic> json) {
    return ClothingItem(
      id: json['id'],
      name: json['name'],
      imagePath: json['imagePath'],
      category: json['category'],
      color: json['color'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  // Copiar con cambios
  ClothingItem copyWith({
    String? id,
    String? name,
    String? imagePath,
    String? category,
    String? color,
    bool? isFavorite,
  }) {
    return ClothingItem(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      category: category ?? this.category,
      color: color ?? this.color,
      isFavorite: isFavorite ?? this.isFavorite,
6ec51dca6f4a8fdb8dc06ad281200c1322473e66
    );
  }
}
