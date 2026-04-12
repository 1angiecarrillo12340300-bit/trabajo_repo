import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/wardrobe_provider.dart';
import '../widgets/clothing_card.dart';
import '../services/api_service.dart';
import '../widgets/suggestions_miniplayer.dart';
import 'favorites_screen.dart';

class GridScreen extends StatefulWidget {
  const GridScreen({super.key});

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  late String _selectedCategory;
  final List<String> _categories = [
    'Todos',
    'Camisetas',
    'Pantalones',
    'Vestidos',
    'Chaquetas',
  ];

  late Future<List<dynamic>> _suggestionsFuture;
  int _categoryIndex = 0;
  bool _showProTip = true;

  Future<void> _vibrate({int duration = 100}) async {
    try {
      await HapticFeedback.mediumImpact();
    } catch (e) {
      // Ignorar si el dispositivo no soporta vibración
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedCategory = 'Todos';
    _suggestionsFuture = ApiService().fetchClothingSuggestions().catchError((_) => <dynamic>[]);

    Future.microtask(
      () => context.read<WardrobeProvider>().loadClothes(),
    );

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() => _showProTip = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '👕 Mi Guardarropa',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[700],
        centerTitle: true,
        elevation: 0,
        actions: [
          Consumer<WardrobeProvider>(
            builder: (context, provider, _) {
              final favoriteCount = provider.getFavorites().length;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    _vibrate(duration: 80);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FavoritesScreen(),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.red[300],
                          size: 28,
                        ),
                        if (favoriteCount > 0)
                          Positioned(
                            top: -2,
                            right: -2,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red[600],
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '$favoriteCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<WardrobeProvider>().loadClothes();
        },
        child: Consumer<WardrobeProvider>(
          builder: (context, wardrobeProvider, child) {
            final clothes = wardrobeProvider.clothes;
            final filteredClothes = _selectedCategory == 'Todos'
                ? clothes
                : clothes
                    .where((item) => item.category == _selectedCategory)
                    .toList();

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  // Espacio arriba
                  const SizedBox(height: 8),
                  // Mini player de sugerencias
                  FutureBuilder<List<dynamic>>(
                    future: _suggestionsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SuggestionsMiniplayer(
                            suggestions: snapshot.data!,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 16),
                  // Categorías
                  _buildCategorySelector(wardrobeProvider),
                  const SizedBox(height: 12),
                  // Contenido
                  if (filteredClothes.isEmpty)
                    _buildEmptyState()
                  else
                    _buildClothesGrid(filteredClothes),
                  // Pro Tip
                  if (_showProTip) _buildProTip(),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategorySelector(WardrobeProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📂 Categorías',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((category) {
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(
                      category,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                    backgroundColor: Colors.grey[200],
                    selectedColor: Colors.blue[600],
                    side: isSelected
                        ? BorderSide(color: Colors.blue[600]!, width: 1)
                        : BorderSide.none,
                    onSelected: (_) {
                      _vibrate(duration: 60);
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.checkroom,
              size: 64,
              color: Colors.blue[300],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No hay prendas en $_selectedCategory',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Agrega nuevas prendas desde la cámara',
            style: TextStyle(fontSize: 13, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildClothesGrid(List clothes) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.75,
        ),
        itemCount: clothes.length,
        itemBuilder: (context, index) {
          return ClothingCard(item: clothes[index]);
        },
      ),
    );
  }

  Widget _buildProTip() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: AnimatedOpacity(
        opacity: _showProTip ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue[200]!, width: 1),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.blue[700], size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pro Tip',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Toca el corazón ❤️ para guardar favoritos',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.blue[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
