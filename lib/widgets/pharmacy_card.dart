import 'package:flutter/material.dart';
import 'package:depi227/core/constants/app_colors.dart';
import 'package:depi227/core/constants/app_strings.dart';
import 'package:depi227/data/models/pharmacy_model.dart';
import 'package:depi227/screens/pharmacy_detail_screen.dart';

class PharmacyCard extends StatelessWidget {
  final Pharmacy pharmacy;

  const PharmacyCard({super.key, required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PharmacyDetailScreen(pharmacy: pharmacy),
          ),
        );
      },
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                // --- CHANGED IMAGE SECTION START ---
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white, // White background for logos
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(
                          12.0), // Adds breathing room around the logo
                      child: pharmacy.imageUrl.startsWith('http')
                          ? Image.network(
                              pharmacy.imageUrl,
                              fit: BoxFit.contain, // Shows the FULL image
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: Colors.grey[50],
                                child: const Icon(Icons.store,
                                    size: 40, color: Colors.grey),
                              ),
                            )
                          : Image.asset(
                              pharmacy.imageUrl,
                              fit: BoxFit.contain, // Shows the FULL image
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: Colors.grey[50],
                                child: const Icon(Icons.store,
                                    size: 40, color: Colors.grey),
                              ),
                            ),
                    ),
                  ),
                ),
                // --- CHANGED IMAGE SECTION END ---

                // Favorite Icon
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.favorite_border, size: 16),
                  ),
                ),
              ],
            ),

            // Pharmacy Info Section
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            pharmacy.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        // CHANGE: Only show if isVerified is true
                        if (pharmacy.isVerified)
                          const Icon(Icons.verified,
                              color: AppColors.primary, size: 14),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      pharmacy.location,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Contact Rows
                    if (pharmacy.whatsapp.isNotEmpty)
                      Row(
                        children: [
                          const Icon(Icons.chat, size: 12, color: Colors.green),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              pharmacy.whatsapp,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 11,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 2),
                    if (pharmacy.phone.isNotEmpty)
                      Row(
                        children: [
                          const Icon(Icons.phone,
                              size: 12, color: AppColors.primary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              pharmacy.phone,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 11,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 10),

                    // Call Button
                    SizedBox(
                      width: double.infinity,
                      height: 36,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Add phone call functionality here
                        },
                        icon: const Icon(Icons.phone, size: 14),
                        label: const Text(
                          AppStrings.call,
                          style: TextStyle(fontSize: 13),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
