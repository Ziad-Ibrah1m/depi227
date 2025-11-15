import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/favorites_provider.dart';
import '../../providers/medicine_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/search_bar.dart';
import '../widgets/product_card.dart';
import '../widgets/empty_state_widget.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Favorite', showLogo: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SearchBarWidget(),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer2<FavoritesProvider, MedicineProvider>(
                builder: (context, favProvider, medProvider, child) {
                  final favoriteMedicines = medProvider.allMedicines
                      .where((med) => favProvider.isFavorite(med.id))
                      .toList();

                  if (favoriteMedicines.isEmpty) {
                    return const EmptyStateWidget(
                      icon: Icons.favorite_border,
                      title: 'No Favorites Yet',
                      message: 'Add medicines to your favorites to see them here',
                    );
                  }

                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: favoriteMedicines.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        medicine: favoriteMedicines[index],
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                medicine: favoriteMedicines[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}