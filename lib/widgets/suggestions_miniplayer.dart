import 'package:flutter/material.dart';
import '../models/product_model.dart';

class SuggestionsMiniplayer extends StatefulWidget {
  const SuggestionsMiniplayer({
    super.key,
    required this.suggestions,
  });

  final List<dynamic> suggestions;

  @override
  State<SuggestionsMiniplayer> createState() => _SuggestionsMiniplayerState();
}

class _SuggestionsMiniplayerState extends State<SuggestionsMiniplayer>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentIndex = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Auto-rotar cada 5 segundos
    if (widget.suggestions.isNotEmpty) {
      Future.delayed(const Duration(seconds: 5), _nextSlide);
    }
  }

  void _nextSlide() {
    if (widget.suggestions.isEmpty) return;
    if (mounted && _pageController.hasClients) {
      final nextPage = (_currentIndex + 1) % widget.suggestions.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      ).then((_) {
        if (mounted) {
          Future.delayed(const Duration(seconds: 5), _nextSlide);
        }
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.suggestions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '💡 Sugerencias de Temporada',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${_currentIndex + 1}/${widget.suggestions.length}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index % widget.suggestions.length;
                });
              },
              itemCount: widget.suggestions.length,
              itemBuilder: (context, index) {
                final item = widget.suggestions[index];
                
                // Extraer datos
                final String imageUrl = _getImageUrl(item);
                final String title = _getTitle(item);
                final double price = _getPrice(item);
                
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              color: Colors.grey[200],
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: imageUrl.isNotEmpty
                                  ? Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[300],
                                          child: const Icon(
                                            Icons.shopping_bag,
                                            color: Colors.grey,
                                            size: 40,
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.shopping_bag,
                                        color: Colors.grey,
                                        size: 40,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      _getCategory(item),
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getImageUrl(dynamic item) {
    if (item is ProductModel) {
      return item.image;
    }
    if (item is Map<String, dynamic>) {
      return item['image'] as String? ?? '';
    }
    return '';
  }

  String _getTitle(dynamic item) {
    if (item is ProductModel) {
      return item.title;
    }
    if (item is Map<String, dynamic>) {
      return item['title'] as String? ?? 'Producto';
    }
    return 'Producto';
  }

  double _getPrice(dynamic item) {
    if (item is ProductModel) {
      return item.price;
    }
    if (item is Map<String, dynamic>) {
      final price = item['price'];
      if (price is num) {
        return price.toDouble();
      }
    }
    return 0.0;
  }

  String _getCategory(dynamic item) {
    if (item is ProductModel) {
      return item.category;
    }
    if (item is Map<String, dynamic>) {
      return item['category'] as String? ?? 'Otros';
    }
    return 'Otros';
  }
}
