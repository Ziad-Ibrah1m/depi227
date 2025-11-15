import '../models/medicine.dart';
import '../services/api_service.dart';

class MedicineRepository {
  final ApiService _apiService = ApiService();

  Future<List<Medicine>> getAllMedicines() async {
    return await _apiService.getMedicines();
  }

  Future<List<Medicine>> getMedicinesByCategory(String category) async {
    return await _apiService.getMedicinesByCategory(category);
  }

  Future<List<Medicine>> searchMedicines(String query) async {
    return await _apiService.searchMedicines(query);
  }
}