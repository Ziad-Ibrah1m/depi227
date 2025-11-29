import 'package:depi227/screens/categories_screen.dart';
import 'package:depi227/screens/favorites_screen.dart';
import 'package:depi227/screens/pharmacies_screen.dart';
import 'package:depi227/screens/popular_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:depi227/core/constants/app_colors.dart';
import 'package:depi227/core/constants/app_strings.dart';
import 'package:depi227/shared/widgets/custom_app_bar.dart';
import 'package:depi227/shared/widgets/custom_search_bar.dart';
import 'package:depi227/shared/widgets/bottom_nav_bar.dart';
import 'package:depi227/data/repositories/product_repository.dart';
import 'package:depi227/widgets/product_card.dart';
import 'package:depi227/widgets/category_card.dart';
import 'package:depi227/widgets/pharmacy_card.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.appName,
        actions: const [], // Remove actions from app bar
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // User Profile Section with aligned icons
            Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              color: Colors.white,
              child: Row(
                children: [
                  // Avatar and User Info
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: const AssetImage('assets/images/user_avatar.png'),
                    onBackgroundImageError: (exception, stackTrace) {},
                    child: const Icon(Icons.person, color: Color.fromARGB(0, 255, 255, 255), size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Hussien',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'sidi bashr',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Favorite Icon
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    iconSize: 26,
                    color: AppColors.primary,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavoritesScreen(),
                        ),
                      );
                    },
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                  // Cart Icon
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    iconSize: 26,
                    color: AppColors.primary,
                    onPressed: () {
                      // Navigate to cart screen
                    },
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            
            const CustomSearchBar(),
            
            // Last Order Section
            _buildSectionHeader(
              AppStrings.lastOrder,
              onMorePressed: () {},
            ),
            _buildProductList(context.watch<ProductRepository>().products.take(2).toList()),
            
            // Categories Section
            _buildSectionHeader(
              AppStrings.categories,
              onMorePressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CategoriesScreen()),
                );
              },
            ),
            _buildCategoriesGrid(context.watch<ProductRepository>().categories.take(3).toList()),
            
            // Pharmacies Section
            _buildSectionHeader(
              AppStrings.pharmacies,
              onMorePressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PharmaciesScreen()),
                );
              },
            ),
            _buildPharmaciesList(context.watch<ProductRepository>().pharmacies),
            
            // Popular Section
            _buildSectionHeader(
              AppStrings.popular,
              onMorePressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PopularScreen()),
                );
              },
            ),
            _buildProductList(context.watch<ProductRepository>().popularProducts.take(2).toList()),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {required VoidCallback onMorePressed}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          GestureDetector(
            onTap: onMorePressed,
            child: Row(
              children: [
                Text(
                  AppStrings.more,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(List products) {
    return SizedBox(
      height: 280,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }

  Widget _buildCategoriesGrid(List categories) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryCard(category: categories[index]);
        },
      ),
    );
  }

  Widget _buildPharmaciesList(List pharmacies) {
    return SizedBox(
      height: 290,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: pharmacies.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return PharmacyCard(pharmacy: pharmacies[index]);
        },
      ),
    );
  }
}