import 'package:flutter/material.dart';
import '../data/models/pharmacy.dart';

class PharmacyProvider with ChangeNotifier {
  List<Pharmacy> _pharmacies = [];
  bool _isLoading = false;

  List<Pharmacy> get pharmacies => _pharmacies;
  bool get isLoading => _isLoading;

  PharmacyProvider() {
    _loadPharmacies();
  }

  void _loadPharmacies() {
    _pharmacies = [
      Pharmacy(
        id: '1',
        name: 'Pharmacy',
        location: 'Sidi Basher , Alex...',
        address: 'Sidi Basher, Alexandria',
        phoneNumber: '010 0000 0000',
        whatsappNumber: '010 0000 0000',
        imageUrl: 'assets/images/pharmacy_placeholder.jpg',
        rating: 4.5,
        isOpen: true,
      ),
      Pharmacy(
        id: '2',
        name: 'Pharmacy',
        location: 'Sidi Basher , Alex...',
        address: 'Sidi Basher, Alexandria',
        phoneNumber: '010 0000 0000',
        whatsappNumber: '010 0000 0000',
        imageUrl: 'assets/images/pharmacy_placeholder.jpg',
        rating: 4.3,
        isOpen: true,
      ),
      Pharmacy(
        id: '3',
        name: 'Pharmacy',
        location: 'Sidi Basher , Alex...',
        address: 'Sidi Basher, Alexandria',
        phoneNumber: '010 0000 0000',
        whatsappNumber: '010 0000 0000',
        imageUrl: 'assets/images/pharmacy_placeholder.jpg',
        rating: 4.7,
        isOpen: true,
      ),
    ];
    notifyListeners();
  }
}