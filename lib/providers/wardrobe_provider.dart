import 'package:flutter/material.dart';
import '../models/clothing_item.dart';
import '../services/storage_service.dart';

class WardrobeProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();

  List<ClothingItem> _clothes = [];
  List<ClothingItem> _favorites = [];

  List<ClothingItem> get clothes => _clothes;
  List<ClothingItem> get favorites => _favorites;

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
  Future<void> addClothing(ClothingItem item) async {
    try {
      _clothes.add(item);
      await _storageService.saveClothes(_clothes);
      notifyListeners();
    } catch (e) {
      print('Error adding clothing: $e');
    }
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
