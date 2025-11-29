import 'package:depi227/data/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:depi227/core/constants/app_strings.dart';
import 'package:depi227/shared/widgets/custom_app_bar.dart';
import 'package:depi227/shared/widgets/custom_search_bar.dart';
import 'package:depi227/widgets/product_card.dart';

class PopularScreen extends StatelessWidget {
  const PopularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final popularProducts = context.watch<ProductRepository>().popularProducts;

    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.popular,
        showBackButton: true,
      ),
      body: Column(
        children: [
          const CustomSearchBar(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: popularProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(product: popularProducts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}