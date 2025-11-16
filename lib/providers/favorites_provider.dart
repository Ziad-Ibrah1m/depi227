import 'package:flutter/material.dart';
import '../data/services/firestore_service.dart';

class FavoritesProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  
  List<String> _favoriteIds = [];
  bool _isLoading = false;

  List<String> get favoriteIds => _favoriteIds;
  bool get isLoading => _isLoading;

  void loadFavorites(String userId) {
    _firestoreService.getFavorites(userId).listen((ids) {
      _favoriteIds = ids;
      notifyListeners();
    });
  }

  bool isFavorite(String medicineId) {
    return _favoriteIds.contains(medicineId);
  }

  Future<void> toggleFavorite(String userId, String medicineId) async {
    try {
      if (isFavorite(medicineId)) {
        await _firestoreService.removeFromFavorites(userId, medicineId);
      } else {
        await _firestoreService.addToFavorites(userId, medicineId);
      }
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }
}
