import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  Future<List<ProductModel>> fetchClothingSuggestions() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/products/category/women%27s%20clothing'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception('Error al cargar sugerencias: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Fallo de red: $e');
    }
  }

  Future<List<ProductModel>> fetchMensSuggestions() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/products/category/men%27s%20clothing'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Fallo de red: $e');
    }
  }
}