import 'package:depi227/screens/related_screen.dart';
import 'package:depi227/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:depi227/core/constants/app_colors.dart';
import 'package:depi227/core/constants/app_strings.dart';
import 'package:depi227/data/repositories/product_repository.dart';
import 'package:depi227/data/models/product_model.dart';

class RelatedProductsWidget extends StatelessWidget {
  final Product currentProduct;

  const RelatedProductsWidget({
    super.key,
    required this.currentProduct,
  });

  @override
  Widget build(BuildContext context) {
    final allProducts = context.watch<ProductRepository>().products;
    
    // Get related products (same category, excluding current)
    final relatedProducts = allProducts
        .where((p) => 
          p.category == currentProduct.category && 
          p.id != currentProduct.id
        )
        .take(4)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.related,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RelatedScreen(
                        currentProduct: currentProduct,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      AppStrings.more,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        relatedProducts.isEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Center(
                  child: Text(
                    'No related products available',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            : SizedBox(
                height: 280,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: relatedProducts.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    return ProductCard(product: relatedProducts[index]);
                  },
                ),
              ),
      ],
    );
  }
}