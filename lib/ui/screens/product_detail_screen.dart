import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/medicine.dart';
import '../../providers/cart_provider.dart';
import '../../providers/favorites_provider.dart';
import '../../providers/medicine_provider.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/section_header.dart';
import '../widgets/product_card.dart';

class ProductDetailScreen extends StatelessWidget {
  final Medicine medicine;
  static const String userId = 'default_user';

  const ProductDetailScreen({Key? key, required this.medicine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final medicineProvider = Provider.of<MedicineProvider>(context);

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image with Favorite Button
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        medicine.imageUrl,
                        height: 200,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.medication,
                            size: 100,
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: GestureDetector(
                        onTap: () {
                          favoritesProvider.toggleFavorite(
                            userId,
                            medicine.id,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Icon(
                            favoritesProvider.isFavorite(medicine.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: AppColors.heartRed,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Product Name and Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      medicine.name,
                      style: AppTextStyles.screenHeader,
                    ),
                  ),
                  Text(
                    '${medicine.price.toStringAsFixed(0)}EG',
                    style: AppTextStyles.price.copyWith(fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'For cold and flu symptoms',
                style: AppTextStyles.productDescription,
              ),
              const SizedBox(height: 24),

              // Overview Section
              Text(
                'Overview',
                style: AppTextStyles.sectionTitle,
              ),
              const SizedBox(height: 12),
              Text(
                medicine.description + 
                '\n\nPanadol Cold & Flu is an over-the-counter medication designed to relieve the symptoms associated with the common cold and flu. It combines paracetamol, a well-known pain reliever and fever reducer, with other active ingredients that help alleviate congestion, runny nose, and body aches. The formula targets headaches, body aches, fever, and sneezing, providing fast and effective relief to help you feel better throughout the day. Panadol Cold & Flu is typically available in tablet or caplet form and should be used according to the recommended dosage instructions.',
                style: AppTextStyles.productDescription.copyWith(height: 1.5),
              ),
              const SizedBox(height: 24),

              // How to Use Section
              Text(
                'How to Use',
                style: AppTextStyles.sectionTitle,
              ),
              const SizedBox(height: 12),
              Text(
                'Panadol Cold & Flu is used to relieve the symptoms of colds and influenza, including headache, sore throat, fever, body congestion, sinus pain, and aches. The recommended dose is as indicated on the packaging or as directed by a doctor or pharmacist. The tablets should be taken with water, with or without food. Do not exceed the stated dose, and avoid using other medications containing paracetamol at the same time.',
                style: AppTextStyles.productDescription.copyWith(height: 1.5),
              ),
              const SizedBox(height: 24),

              // Related Products Section
              SectionHeader(
                title: 'Related',
                onMoreTap: () {},
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: medicineProvider.allMedicines.length > 4 
                      ? 4 
                      : medicineProvider.allMedicines.length,
                  itemBuilder: (context, index) {
                    final relatedMedicine = medicineProvider.allMedicines[index];
                    if (relatedMedicine.id == medicine.id) return const SizedBox();
                    return Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 12),
                      child: ProductCard(
                        medicine: relatedMedicine,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                medicine: relatedMedicine,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Active Ingredient Section
              SectionHeader(
                title: 'Active ingredient',
                onMoreTap: () {},
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    final sameMedicines = medicineProvider.allMedicines
                        .where((m) => m.activeIngredient == medicine.activeIngredient)
                        .take(2)
                        .toList();
                    if (sameMedicines.isEmpty || index >= sameMedicines.length) {
                      return const SizedBox();
                    }
                    return Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 12),
                      child: ProductCard(
                        medicine: sameMedicines[index],
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                medicine: sameMedicines[index],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                cartProvider.addToCart(
                  medicine,
                  userId,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Added to cart'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Add to cart',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}