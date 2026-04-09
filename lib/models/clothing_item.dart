class ClothingItem {
  final String id;
  final String name;
  final String imagePath;

  ClothingItem({
    required this.id,
    required this.name,
    required this.imagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
    };
  }

  factory ClothingItem.fromJson(Map<String, dynamic> json) {
    return ClothingItem(
      id: json['id'],
      name: json['name'],
      imagePath: json['imagePath'],
    );
  }
}