import 'package:flutter/material.dart';
import '../models/clothing_item.dart';
import '../services/storage_service.dart';
import 'package:uuid/uuid.dart';

class WardrobeProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();

  List<ClothingItem> _clothes = [];

  List<ClothingItem> get clothes => _clothes;

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
      isFavorite: false,
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
    }
  }
}