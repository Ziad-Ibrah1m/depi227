import 'package:depi227/data/models/category_model.dart';
import 'package:depi227/screens/category_products_screen.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProductsScreen(category: category),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: category.backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Use asset or network icon depending on iconPath content
            (category.iconPath.startsWith('http')
                ? Image.network(
                    category.iconPath,
                    width: 40, // Changed from 32 to 40
                    height: 40, // Changed from 32 to 40
                    fit: BoxFit.contain,
                    errorBuilder: (ctx, err, stack) => const Icon(
                        Icons.error), // Helps debug if link is broken
                  )
                : Image.asset(
                    category.iconPath,
                    width: 32,
                    height: 32,
                    fit: BoxFit.contain,
                  )),
            const SizedBox(height: 8),
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: category.iconColor,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
