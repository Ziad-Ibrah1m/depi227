import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final bool showLogo;
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    this.title,
    this.showBackButton = true,
    this.showLogo = true,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.textDark),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: showLogo
          ? Image.asset(
              AppConstants.logoPath,
              height: 32,
              errorBuilder: (context, error, stackTrace) {
                return const Text(
                  'Medlink',
                  style: TextStyle(
                    color: AppColors.primaryBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            )
          : title != null
              ? Text(
                  title!,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}