import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../data/models/cart_item.dart';
import '../data/models/medicine.dart';
import '../data/services/firestore_service.dart';

class CartProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final Uuid _uuid = Uuid();
  
  List<CartItem> _items = [];
  bool _isLoading = false;

  List<CartItem> get items => _items;
  bool get isLoading => _isLoading;
  int get itemCount => _items.length;
  
  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  void loadCartItems(String userId) {
    _firestoreService.getCartItems(userId).listen((items) {
      _items = items;
      notifyListeners();
    });
  }

  Future<void> addToCart(Medicine medicine, String userId) async {
    try {
      final existingIndex = _items.indexWhere(
        (item) => item.medicine.id == medicine.id,
      );

      if (existingIndex >= 0) {
        final updatedItem = _items[existingIndex];
        await _firestoreService.updateCartItemQuantity(
          userId,
          updatedItem.id,
          updatedItem.quantity + 1,
        );
      } else {
        final cartItem = CartItem(
          id: _uuid.v4(),
          medicine: medicine,
          quantity: 1,
          addedAt: DateTime.now(),
        );
        await _firestoreService.addToCart(userId, cartItem);
      }
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  Future<void> removeFromCart(String userId, String itemId) async {
    try {
      await _firestoreService.removeFromCart(userId, itemId);
    } catch (e) {
      print('Error removing from cart: $e');
    }
  }

  Future<void> updateQuantity(String userId, String itemId, int quantity) async {
    try {
      if (quantity <= 0) {
        await removeFromCart(userId, itemId);
      } else {
        await _firestoreService.updateCartItemQuantity(userId, itemId, quantity);
      }
    } catch (e) {
      print('Error updating quantity: $e');
    }
  }

  Future<void> clearCart(String userId) async {
    try {
      await _firestoreService.clearCart(userId);
    } catch (e) {
      print('Error clearing cart: $e');
    }
  }
}