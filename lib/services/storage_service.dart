import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/clothing_item.dart';

class StorageService {
  static const String key = 'clothes';

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
}