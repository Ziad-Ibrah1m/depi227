import 'package:flutter/material.dart';
import '../../utils/text_styles.dart';

class CategoryTile extends StatelessWidget {
  final String name;
  final String iconPath;
  final Color backgroundColor;
  final VoidCallback onTap;

  const CategoryTile({
    Key? key,
    required this.name,
    required this.iconPath,
    required this.backgroundColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getCategoryIcon(name),
              size: 40,
              color: _getIconColor(name),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: AppTextStyles.categoryLabel,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String name) {
    if (name.contains('Heart')) return Icons.favorite;
    if (name.contains('Cold')) return Icons.ac_unit;
    if (name.contains('Mental')) return Icons.psychology;
    if (name.contains('Pain')) return Icons.healing;
    if (name.contains('Baby')) return Icons.child_care;
    if (name.contains('Vitamins')) return Icons.medication;
    if (name.contains('Skin')) return Icons.face;
    if (name.contains('Eye')) return Icons.visibility;
    if (name.contains('First')) return Icons.medical_services;
    return Icons.medication;
  }

  Color _getIconColor(String name) {
    if (name.contains('Heart')) return Colors.red;
    if (name.contains('Cold')) return Colors.blue;
    if (name.contains('Mental')) return Colors.purple;
    if (name.contains('Pain')) return Colors.red[300]!;
    if (name.contains('Baby')) return Colors.amber;
    if (name.contains('Vitamins')) return Colors.green;
    if (name.contains('Skin')) return Colors.purple[300]!;
    if (name.contains('Eye')) return Colors.blue[300]!;
    if (name.contains('First')) return Colors.pink;
    return Colors.blue;
  }
}