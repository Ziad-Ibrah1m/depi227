import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/cart_item.dart';
import '../../providers/cart_provider.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  static const String userId = 'default_user';

  const CartItemCard({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightBlue, width: 2),
      ),
      child: Row(
        children: [
          // Product image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              cartItem.medicine.imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.medication, size: 40);
              },
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Product info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.medicine.name,
                  style: AppTextStyles.productName.copyWith(fontSize: 15),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  cartItem.medicine.description,
                  style: AppTextStyles.productDescription,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '${cartItem.medicine.price.toStringAsFixed(0)}EG',
                      style: AppTextStyles.price.copyWith(fontSize: 14),
                    ),
                    const Spacer(),
                    Text(
                      'total : ${cartItem.totalPrice.toStringAsFixed(0)}EG',
                      style: AppTextStyles.productName.copyWith(fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 8),
          
          // Quantity controls and delete
          Column(
            children: [
              IconButton(
                onPressed: () {
                  cartProvider.removeFromCart(
                    userId,
                    cartItem.id,
                  );
                },
                icon: const Icon(Icons.delete, color: AppColors.deleteRed),
                iconSize: 20,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      cartProvider.updateQuantity(
                        userId,
                        cartItem.id,
                        cartItem.quantity - 1,
                      );
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.textGray),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.remove, size: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      '${cartItem.quantity}',
                      style: AppTextStyles.productName,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      cartProvider.updateQuantity(
                        userId,
                        cartItem.id,
                        cartItem.quantity + 1,
                      );
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.textGray),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, size: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}