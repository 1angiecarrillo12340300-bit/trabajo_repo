import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/clothing_item.dart';
import '../services/storage_service.dart';

class WardrobeProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();

  List<ClothingItem> _clothes = [];

  List<ClothingItem> get clothes => _clothes;

  // Cargar datos al iniciar
  Future<void> loadClothes() async {
    try {
      _clothes = await _storageService.loadClothes();
      notifyListeners();
    } catch (e) {
      print('Error loading clothes: $e');
    }
  }

  // ➕ Agregar prenda
  Future<void> addClothing(String name, String imagePath,
      {String? category, String? color}) async {
    final newItem = ClothingItem(
      id: const Uuid().v4(),
      name: name,
      imagePath: imagePath,
      category: category,
      color: color,
      isFavorite: false,
    );

    _clothes.add(newItem);
    await _storageService.saveClothes(_clothes);
    notifyListeners();
  }

  // ❌ Eliminar prenda
  Future<void> removeClothing(String id) async {
    try {
      _clothes.removeWhere((item) => item.id == id);
      await _storageService.saveClothes(_clothes);
      notifyListeners();
    } catch (e) {
      print('Error removing clothing: $e');
    }
  }

  // ⭐ Toggle favorito
  Future<void> toggleFavorite(ClothingItem item) async {
    try {
      final index = _clothes.indexWhere((e) => e.id == item.id);
      if (index != -1) {
        _clothes[index] = _clothes[index].copyWith(
          isFavorite: !_clothes[index].isFavorite,
        );
        await _storageService.saveClothes(_clothes);
        notifyListeners();
      }
    } catch (e) {
      notifyListeners();
    }
  }

  // Obtener favoritos
  List<ClothingItem> getFavorites() {
    return _clothes.where((item) => item.isFavorite).toList();
  }

  // Verificar si es favorito
  bool isFavorite(String id) {
    return _clothes.any((item) => item.id == id && item.isFavorite);
  }

  // Obtener prenda por ID
  ClothingItem? getClothingById(String id) {
    try {
      return _clothes.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }
}