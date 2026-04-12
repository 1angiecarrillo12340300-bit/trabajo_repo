import 'package:flutter/material.dart';
import '../models/clothing_item.dart';
import '../services/storage_service.dart';

class WardrobeProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();

  List<ClothingItem> _clothes = [];

  List<ClothingItem> get clothes => _clothes;

  //  Cargar datos al iniciar
  Future<void> loadClothes() async {
    try {
      _clothes = await _storageService.loadClothes();
      _favorites = await _storageService.loadFavorites();
      notifyListeners();
    } catch (e) {
      print('Error loading clothes: $e');
    }
  }

  // ➕ Agregar prenda
<<<<<<< HEAD
  Future<void> addClothing(ClothingItem item) async {
    try {
      _clothes.add(item);
      await _storageService.saveClothes(_clothes);
      notifyListeners();
    } catch (e) {
      print('Error adding clothing: $e');
    }
=======
  Future<void> addClothing(String name, String imagePath, {String? category, String? color}) async {
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
>>>>>>> 6ec51dca6f4a8fdb8dc06ad281200c1322473e66
  }

  // Eliminar prenda
  Future<void> removeClothing(String id) async {
    try {
      _clothes.removeWhere((item) => item.id == id);
      _favorites.removeWhere((item) => item.id == id);
      await _storageService.saveClothes(_clothes);
      await _storageService.saveFavorites(_favorites);
      notifyListeners();
    } catch (e) {
      print('Error removing clothing: $e');
    }
  }

<<<<<<< HEAD
  // 🤍 Favoritos
  Future<void> toggleFavorite(ClothingItem item) async {
    try {
      if (_favorites.contains(item)) {
        _favorites.remove(item);
      } else {
        _favorites.add(item);
      }
      await _storageService.saveFavorites(_favorites);
      notifyListeners();
    } catch (e) {
      print('Error toggling favorite: $e');
=======
  // Toggle favorito
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
      // Error manejado, no hace nada
      notifyListeners();
    }
  }

  // Obtener favoritos
  List<ClothingItem> getFavorites() {
    try {
      return _clothes.where((item) => item.isFavorite).toList();
    } catch (e) {
      return [];
    }
  }

  // Verificar si es favorito
  bool isFavorite(String id) {
    try {
      return _clothes.any((item) => item.id == id && item.isFavorite);
    } catch (e) {
      return false;
>>>>>>> 6ec51dca6f4a8fdb8dc06ad281200c1322473e66
    }
  }

  // Verificar si un item es favorito
  bool isFavorite(ClothingItem item) {
    return _favorites.contains(item);
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
