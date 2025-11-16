import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart' as app_user;
import '../models/order.dart' as app_order;
import '../models/cart_item.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==========================================
  // USERS COLLECTION OPERATIONS
  // ==========================================

  // Create a new user document
  Future<void> createUser(app_user.User user) async {
    await _firestore.collection('users').doc(user.id).set(user.toJson());
  }

  // Get user by ID
  Future<app_user.User?> getUser(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return app_user.User.fromJson(doc.data()!);
    }
    return null;
  }

  // Update user information
  Future<void> updateUser(app_user.User user) async {
    await _firestore.collection('users').doc(user.id).update(user.toJson());
  }

  // ==========================================
  // CART COLLECTION OPERATIONS
  // ==========================================

  // Get cart items as a real-time stream
  Stream<List<CartItem>> getCartItems(String userId) {
    return _firestore
        .collection('cart')
        .doc(userId)
        .collection('items')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => CartItem.fromJson(doc.data()))
          .toList();
    });
  }

  // Add item to cart
  Future<void> addToCart(String userId, CartItem item) async {
    await _firestore
        .collection('cart')
        .doc(userId)
        .collection('items')
        .doc(item.id)
        .set(item.toJson());
  }

  // Remove item from cart
  Future<void> removeFromCart(String userId, String itemId) async {
    await _firestore
        .collection('cart')
        .doc(userId)
        .collection('items')
        .doc(itemId)
        .delete();
  }

  // Update cart item quantity
  Future<void> updateCartItemQuantity(
    String userId,
    String itemId,
    int quantity,
  ) async {
    await _firestore
        .collection('cart')
        .doc(userId)
        .collection('items')
        .doc(itemId)
        .update({'quantity': quantity});
  }

  // Clear entire cart
  Future<void> clearCart(String userId) async {
    final batch = _firestore.batch();
    final snapshot = await _firestore
        .collection('cart')
        .doc(userId)
        .collection('items')
        .get();

    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  // ==========================================
  // ORDERS COLLECTION OPERATIONS
  // ==========================================

  // Create a new order
  Future<void> createOrder(app_order.Order order) async {
    await _firestore.collection('orders').doc(order.id).set(order.toJson());
  }

  // Get all orders for a user (real-time stream)
  Stream<List<app_order.Order>> getUserOrders(String userId) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('orderDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => app_order.Order.fromJson(doc.data())).toList();
    });
  }

  // Get a single order by ID
  Future<app_order.Order?> getOrder(String orderId) async {
    final doc = await _firestore.collection('orders').doc(orderId).get();
    if (doc.exists) {
      return app_order.Order.fromJson(doc.data()!);
    }
    return null;
  }

  // Update order status
  Future<void> updateOrderStatus(String orderId, app_order.OrderStatus status) async {
    await _firestore.collection('orders').doc(orderId).update({
      'status': status.toString().split('.').last,
    });
  }

  // ==========================================
  // FAVORITES COLLECTION OPERATIONS
  // ==========================================

  // Get favorites as a real-time stream
  Stream<List<String>> getFavorites(String userId) {
    return _firestore
        .collection('favorites')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return List<String>.from(snapshot.data()?['medicineIds'] ?? []);
      }
      return [];
    });
  }

  // Add medicine to favorites
  Future<void> addToFavorites(String userId, String medicineId) async {
    await _firestore.collection('favorites').doc(userId).set({
      'medicineIds': [medicineId],
    }, SetOptions(merge: true));
  }

  // Remove medicine from favorites
  Future<void> removeFromFavorites(String userId, String medicineId) async {
    await _firestore.collection('favorites').doc(userId).get().then((doc) {
      if (doc.exists) {
        List<String> medicineIds =
            List<String>.from(doc.data()?['medicineIds'] ?? []);
        medicineIds.remove(medicineId);
        _firestore
            .collection('favorites')
            .doc(userId)
            .update({'medicineIds': medicineIds});
      }
    });
  }
}