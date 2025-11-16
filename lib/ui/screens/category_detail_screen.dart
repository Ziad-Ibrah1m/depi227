import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/medicine_provider.dart';
import '../../utils/colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/search_bar.dart';
import '../widgets/product_card.dart';
import '../widgets/loading_widget.dart';
import 'product_detail_screen.dart';

class CategoryDetailScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const CategoryDetailScreen({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MedicineProvider>(context, listen: false)
          .loadMedicinesByCategory(widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showLogo: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textDark),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {},
            style: IconButton.styleFrom(
              backgroundColor: AppColors.buttonBlue,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Header
            Row(
              children: [
                Icon(
                  _getCategoryIcon(widget.categoryName),
                  color: AppColors.primaryBlue,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.categoryName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Search Bar
            const SearchBarWidget(),
            const SizedBox(height: 20),
            
            // Products Grid
            Expanded(
              child: Consumer<MedicineProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const LoadingWidget();
                  }

                  final medicines = provider.filteredMedicines;

                  if (medicines.isEmpty) {
                    return const Center(
                      child: Text('No medicines found in this category'),
                    );
                  }

                  return GridView.builder(
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
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String name) {
    if (name.contains('Cold')) return Icons.ac_unit;
    if (name.contains('Heart')) return Icons.favorite;
    if (name.contains('Mental')) return Icons.psychology;
    if (name.contains('Pain')) return Icons.healing;
    if (name.contains('Baby')) return Icons.child_care;
    if (name.contains('Vitamins')) return Icons.medication;
    if (name.contains('Skin')) return Icons.face;
    if (name.contains('Eye')) return Icons.visibility;
    if (name.contains('First')) return Icons.medical_services;
    return Icons.medication;
  }
}