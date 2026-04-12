import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/clothing_item.dart';

class StorageService {
  static const String key = 'clothes';
  static const String favoritesKey = 'favorites';

  Future<void> saveClothes(List<ClothingItem> clothes) async {
    final prefs = await SharedPreferences.getInstance();
    final data = clothes.map((e) => e.toJson()).toList();
    prefs.setString(key, jsonEncode(data));
  }

  Future<List<ClothingItem>> loadClothes() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);

    if (data == null) return [];

    List decoded = jsonDecode(data);
    return decoded.map((e) => ClothingItem.fromJson(e)).toList();
  }

  Future<void> saveFavorites(List<ClothingItem> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final data = favorites.map((e) => e.toJson()).toList();
    prefs.setString(favoritesKey, jsonEncode(data));
  }

  Future<List<ClothingItem>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(favoritesKey);

    if (data == null) return [];

    List decoded = jsonDecode(data);
    return decoded.map((e) => ClothingItem.fromJson(e)).toList();
  }
}
