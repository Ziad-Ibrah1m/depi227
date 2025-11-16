import '../models/cart_item.dart';
import '../services/firestore_service.dart';

class CartRepository {
  final FirestoreService _firestoreService = FirestoreService();

  Stream<List<CartItem>> getCartItems(String userId) {
    return _firestoreService.getCartItems(userId);
  }

  Future<void> addToCart(String userId, CartItem item) async {
    await _firestoreService.addToCart(userId, item);
  }

  Future<void> removeFromCart(String userId, String itemId) async {
    await _firestoreService.removeFromCart(userId, itemId);
  }

  Future<void> updateQuantity(String userId, String itemId, int quantity) async {
    await _firestoreService.updateCartItemQuantity(userId, itemId, quantity);
  }

  Future<void> clearCart(String userId) async {
    await _firestoreService.clearCart(userId);
  }
}