import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/medicine_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/favorites_provider.dart';
import '../../providers/pharmacy_provider.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../widgets/search_bar.dart';
import '../widgets/section_header.dart';
import '../widgets/product_card.dart';
import '../widgets/category_tile.dart';
import '../widgets/pharmacy_card.dart';
import '../widgets/bottom_nav_bar.dart';
import 'categories_screen.dart';
import 'last_order_screen.dart';
import 'pharmacies_screen.dart';
import 'popular_screen.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart';
import 'order_history_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  // Mock user ID - replace with your actual user ID or authentication system
  static const String userId = 'default_user';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final medicineProvider = Provider.of<MedicineProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);
    
    medicineProvider.loadMedicines();
    cartProvider.loadCartItems(userId);
    favoritesProvider.loadFavorites(userId);
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex == 1) {
      return const OrderHistoryScreen();
    } else if (_currentIndex == 2) {
      return const ProfileScreen();
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SearchBarWidget(
                        controller: _searchController,
                        onChanged: (query) {
                          Provider.of<MedicineProvider>(context, listen: false)
                              .searchMedicines(query);
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildLastOrderSection(),
                      const SizedBox(height: 24),
                      _buildCategoriesSection(),
                      const SizedBox(height: 24),
                      _buildPharmaciesSection(),
                      const SizedBox(height: 24),
                      _buildPopularSection(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.lightBlue,
            child: const Icon(Icons.person, size: 28, color: AppColors.primaryBlue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Hello, User',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: AppColors.textGray),
                    SizedBox(width: 4),
                    Text(
                      'Alexandria, Egypt',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textGray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: AppColors.textDark),
            onPressed: () {
              // Navigate to favorites
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: AppColors.textDark),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLastOrderSection() {
    return Column(
      children: [
        SectionHeader(
          title: 'Last Order',
          onMoreTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LastOrderScreen()),
            );
          },
        ),
        SizedBox(
          height: 240,
          child: Consumer<MedicineProvider>(
            builder: (context, provider, child) {
              final medicines = provider.allMedicines.take(2).toList();
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: medicines.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 160,
                    margin: const EdgeInsets.only(right: 12),
                    child: ProductCard(
                      medicine: medicines[index],
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                              medicine: medicines[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      children: [
        SectionHeader(
          title: 'Categories',
          onMoreTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CategoriesScreen()),
            );
          },
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: 3,
          itemBuilder: (context, index) {
            final category = AppConstants.categories[index];
            return CategoryTile(
              name: category['name'],
              iconPath: category['icon'],
              backgroundColor: category['color'],
              onTap: () {
                // Navigate to category detail
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildPharmaciesSection() {
    final pharmacyProvider = Provider.of<PharmacyProvider>(context);

    return Column(
      children: [
        SectionHeader(
          title: 'Pharmacies',
          onMoreTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const PharmaciesScreen()),
            );
          },
        ),
        if (pharmacyProvider.pharmacies.isNotEmpty)
          PharmacyCard(pharmacy: pharmacyProvider.pharmacies.first),
      ],
    );
  }

  Widget _buildPopularSection() {
    return Column(
      children: [
        SectionHeader(
          title: 'popular',
          onMoreTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const PopularScreen()),
            );
          },
        ),
        Consumer<MedicineProvider>(
          builder: (context, provider, child) {
            final medicines = provider.allMedicines.take(2).toList();
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  medicine: medicines[index],
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          medicine: medicines[index],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}