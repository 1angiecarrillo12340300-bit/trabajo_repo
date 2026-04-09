import 'package:flutter/material.dart';
import '../models/clothing_item.dart';

class WardrobeProvider with ChangeNotifier {
  List<ClothingItem> _clothes = [];

  List<ClothingItem> get clothes => _clothes;

  void addClothingItem(ClothingItem item) {
    _clothes.add(item);
    notifyListeners();
  }

  void removeClothingItem(ClothingItem item) {
    _clothes.remove(item);
    notifyListeners();
  }
}