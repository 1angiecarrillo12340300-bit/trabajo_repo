class ClothingItem {
  final String id;
  final String name;
  final String imagePath;
  final String? category;
  final String? color;
  bool isFavorite;

  ClothingItem({
    required this.id,
    required this.name,
    required this.imagePath,
    this.category,
    this.color,
    this.isFavorite = false,
  });

  // Convertir a JSON
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
    );
  }
}