import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String _baseUrl = 'https://dummyjson.com';

  Future<List<ProductModel>> fetchClothingSuggestions() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/products/category/womens-dresses'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> products = data['products'];
        return products.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception('Error al cargar sugerencias: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Fallo de red: $e');
    }
  }
}