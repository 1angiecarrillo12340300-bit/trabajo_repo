import 'package:flutter/material.dart';
import '../models/clothing_item.dart';
import '../services/storage_service.dart';
import 'package:uuid/uuid.dart';

class WardrobeProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();

  List<ClothingItem> _clothes = [];
  List<ClothingItem> _favorites = [];

  List<ClothingItem> get clothes => _clothes;
  List<ClothingItem> get favorites => _favorites;

  //  Cargar datos al iniciar
  Future<void> loadClothes() async {
    _clothes = await _storageService.loadClothes();
    notifyListeners();
  }

  // ➕ Agregar prenda
  Future<void> addClothing(String name, String imagePath, {String? category, String? color}) async {
    final newItem = ClothingItem(
      id: const Uuid().v4(),
      name: name,
      imagePath: imagePath,
      category: category,
      color: color,
    );

    _clothes.add(newItem);
    await _storageService.saveClothes(_clothes);
    notifyListeners();
  }

  // Eliminar prenda
  Future<void> removeClothing(String id) async {
    _clothes.removeWhere((item) => item.id == id);
    await _storageService.saveClothes(_clothes);
    notifyListeners();
  }

  // Favoritos
  void toggleFavorite(ClothingItem item) {
    if (_favorites.contains(item)) {
      _favorites.remove(item);
    } else {
      _favorites.add(item);
    }
    notifyListeners();
  }
}