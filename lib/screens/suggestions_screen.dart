import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class SuggestionsScreen extends StatefulWidget {
  const SuggestionsScreen({super.key});

  @override
  State<SuggestionsScreen> createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<ProductModel>> _suggestions;

  // Datos de fallback para cuando la API falle
  static final List<ProductModel> _fallbackProducts = [
    ProductModel(
      id: 1,
      title: 'Vestido Elegante Negro',
      price: 79.99,
      category: 'vestidos',
      image: 'https://via.placeholder.com/200?text=Vestido+Negro',
    ),
    ProductModel(
      id: 2,
      title: 'Blusa Casual Blanca',
      price: 39.99,
      category: 'blusas',
      image: 'https://via.placeholder.com/200?text=Blusa+Blanca',
    ),
    ProductModel(
      id: 3,
      title: 'Pantalón Vaquero',
      price: 59.99,
      category: 'pantalones',
      image: 'https://via.placeholder.com/200?text=Pantalon+Vaquero',
    ),
    ProductModel(
      id: 4,
      title: 'Chaqueta de Cuero',
      price: 119.99,
      category: 'chaquetas',
      image: 'https://via.placeholder.com/200?text=Chaqueta+Cuero',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _suggestions = _apiService.fetchClothingSuggestions().catchError((e) {
      // Si la API falla, usar datos de fallback
      return _fallbackProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sugerencias de Temporada'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: _suggestions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Cargando sugerencias...'),
                ],
              ),
            );
          }

          final products = snapshot.data ?? _fallbackProducts;

          if (products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_bag, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('No hay sugerencias disponibles'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _suggestions =
                            _apiService.fetchClothingSuggestions().catchError((e) {
                          return _fallbackProducts;
                        });
                      });
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          color: Colors.grey[200],
                        ),
                        child: Image.network(
                          product.image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.shopping_bag,
                                color: Colors.grey,
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}