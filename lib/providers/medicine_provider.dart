import 'package:flutter/material.dart';
import '../data/models/medicine.dart';
import '../data/services/api_service.dart';

class MedicineProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  List<Medicine> _allMedicines = [];
  List<Medicine> _filteredMedicines = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Medicine> get allMedicines => _allMedicines;
  List<Medicine> get filteredMedicines => _filteredMedicines;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

Future<void> loadMedicines() async {
  _isLoading = true;
  _errorMessage = null;
  notifyListeners();

  try {
    _allMedicines = await _apiService.getMedicines();
    _filteredMedicines = _allMedicines;
  } catch (e) {
    _errorMessage = e.toString();
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}

  Future<void> loadMedicinesByCategory(String category) async {
    _isLoading = true;
    notifyListeners();

    try {
      _filteredMedicines = await _apiService.getMedicinesByCategory(category);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchMedicines(String query) async {
    if (query.isEmpty) {
      _filteredMedicines = _allMedicines;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      _filteredMedicines = await _apiService.searchMedicines(query);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Medicine> getMedicinesByCategory(String category) {
    return _allMedicines
        .where((medicine) => medicine.category == category)
        .toList();
  }

  Medicine? getMedicineById(String id) {
    try {
      return _allMedicines.firstWhere((medicine) => medicine.id == id);
    } catch (e) {
      return null;
    }
  }
}