import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depi227/data/models/product_model.dart';
import 'package:depi227/data/models/category_model.dart';
import 'package:depi227/data/models/pharmacy_model.dart';

class ProductRepository extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Private Lists
  List<Product> _products = [];
  List<Category> _categories = [];
  List<Pharmacy> _pharmacies = [];

  // Subscriptions to cancel when app closes
  StreamSubscription<QuerySnapshot>? _productsSub;
  StreamSubscription<QuerySnapshot>? _categoriesSub;
  StreamSubscription<QuerySnapshot>? _pharmaciesSub;

  ProductRepository() {
    _initListeners();
  }

  void _initListeners() {
    // 1. Listen to Products
    _productsSub = _db
        .collection('products')
        .where('published', isEqualTo: true)
        .snapshots()
        .listen((snap) {
      final favMap = {for (var p in _products) p.id: p.isFavorite};
      _products = snap.docs.map((doc) {
        final prod = Product.fromFirestore(doc);
        prod.isFavorite = favMap[prod.id] ?? false;
        return prod;
      }).toList();
      notifyListeners();
    });

    // 2. Listen to Categories (Modified to fix missing Index issue)
    _categoriesSub = _db
        .collection('categories')
        .snapshots() // Removed .where and .orderBy to avoid index errors
        .listen((snap) {
      _categories =
          snap.docs.map((doc) => Category.fromFirestore(doc)).toList();

      // Sort manually in Dart
      _categories.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));

      notifyListeners();
    });

    // 3. Listen to Pharmacies
    _pharmaciesSub = _db.collection('pharmacies').snapshots().listen((snap) {
      _pharmacies =
          snap.docs.map((doc) => Pharmacy.fromFirestore(doc)).toList();
      notifyListeners();
    });
  }

  // Getters
  List<Product> get products => List.unmodifiable(_products);
  List<Category> get categories => List.unmodifiable(_categories);
  List<Pharmacy> get pharmacies => List.unmodifiable(_pharmacies);

  // Filtered Getters
  List<Product> get favoriteProducts =>
      _products.where((p) => p.isFavorite).toList();

  // Now dynamically filters by the 'isPopular' field in Firestore
  List<Product> get popularProducts =>
      _products.where((p) => p.isPopular).toList();

  // Actions
  void toggleFavorite(String productId) {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      _products[index].isFavorite = !_products[index].isFavorite;
      notifyListeners();
    }
  }

  // Simple Search Function
  List<Product> searchProducts(String query) {
    if (query.isEmpty) return [];
    return _products.where((p) {
      return p.name.toLowerCase().contains(query.toLowerCase()) ||
          p.searchKeywords.contains(query.toLowerCase());
    }).toList();
  }

  @override
  void dispose() {
    _productsSub?.cancel();
    _categoriesSub?.cancel();
    _pharmaciesSub?.cancel();
    super.dispose();
  }
}
