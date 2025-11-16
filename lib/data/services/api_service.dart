import '../models/medicine.dart';

class ApiService {
  // Base URL for medicine API (currently using mock data)
  // Replace with actual API endpoint when ready
  static const String baseUrl = 'https://api.fda.gov/drug';
  
  // Get all medicines
  Future<List<Medicine>> getMedicines() async {
    try {
      // TODO: Replace with actual API call
      // Example:
      // final dio = Dio();
      // final response = await dio.get('$baseUrl/medicines');
      // return (response.data as List)
      //     .map((json) => Medicine.fromJson(json))
      //     .toList();
      
      // For now, return mock data
      return _getMockMedicines();
    } catch (e) {
      print('Error fetching medicines: $e');
      return [];
    }
  }

  // Get medicines by category
  Future<List<Medicine>> getMedicinesByCategory(String category) async {
    try {
      final allMedicines = await getMedicines();
      return allMedicines
          .where((medicine) => medicine.category == category)
          .toList();
    } catch (e) {
      print('Error fetching medicines by category: $e');
      return [];
    }
  }

  // Search medicines by name or description
  Future<List<Medicine>> searchMedicines(String query) async {
    try {
      final allMedicines = await getMedicines();
      return allMedicines
          .where((medicine) =>
              medicine.name.toLowerCase().contains(query.toLowerCase()) ||
              medicine.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      print('Error searching medicines: $e');
      return [];
    }
  }

  // Get medicine by ID
  Future<Medicine?> getMedicineById(String id) async {
    try {
      final allMedicines = await getMedicines();
      return allMedicines.firstWhere((medicine) => medicine.id == id);
    } catch (e) {
      print('Error fetching medicine by ID: $e');
      return null;
    }
  }

  // MOCK DATA - Replace with actual API integration
  List<Medicine> _getMockMedicines() {
    return [
      Medicine(
        id: '1',
        name: 'Panadol',
        description: 'Panadol clod & flu',
        price: 90.0,
        imageUrl: 'assets/images/panadol.png',
        category: 'cold_flu',
        dosage: '500mg',
        manufacturer: 'GSK',
        stock: 50,
        rating: 4.5,
        activeIngredient: 'Paracetamol',
      ),
      Medicine(
        id: '2',
        name: 'Ibuprofen',
        description: 'Pain relief and a...',
        price: 90.0,
        imageUrl: 'assets/images/panadol.png',
        category: 'pain_relief',
        dosage: '200mg',
        manufacturer: 'Generic',
        stock: 100,
        rating: 4.3,
        activeIngredient: 'Ibuprofen',
      ),
      Medicine(
        id: '3',
        name: 'Cetirizine',
        description: 'Allergy relief',
        price: 90.0,
        imageUrl: 'assets/images/panadol.png',
        category: 'cold_flu',
        dosage: '10mg',
        manufacturer: 'Generic',
        stock: 75,
        rating: 4.6,
        activeIngredient: 'Cetirizine',
      ),
      Medicine(
        id: '4',
        name: 'Aspirin',
        description: 'Pain relief and blood thinner',
        price: 90.0,
        imageUrl: 'assets/images/panadol.png',
        category: 'heart_medications',
        dosage: '75mg',
        manufacturer: 'Bayer',
        stock: 60,
        rating: 4.4,
        activeIngredient: 'Acetylsalicylic Acid',
      ),
      Medicine(
        id: '5',
        name: 'Vitamin D3',
        description: 'Essential vitamin for bone health',
        price: 90.0,
        imageUrl: 'assets/images/panadol.png',
        category: 'vitamins',
        dosage: '1000 IU',
        manufacturer: 'Nature Made',
        stock: 120,
        rating: 4.7,
        activeIngredient: 'Cholecalciferol',
      ),
      Medicine(
        id: '6',
        name: 'Omega-3 Fish Oil',
        description: 'Supports heart and brain health',
        price: 90.0,
        imageUrl: 'assets/images/panadol.png',
        category: 'vitamins',
        dosage: '1000mg',
        manufacturer: 'Nordic Naturals',
        stock: 80,
        rating: 4.5,
        activeIngredient: 'EPA/DHA',
      ),
      Medicine(
        id: '7',
        name: 'Baby Cough Syrup',
        description: 'Gentle cough relief for infants',
        price: 90.0,
        imageUrl: 'assets/images/panadol.png',
        category: 'baby_care',
        dosage: '5ml',
        manufacturer: "Zarbee's",
        stock: 45,
        rating: 4.3,
        activeIngredient: 'Honey',
      ),
      Medicine(
        id: '8',
        name: 'Hydrocortisone Cream',
        description: 'Topical cream for skin irritation',
        price: 90.0,
        imageUrl: 'assets/images/panadol.png',
        category: 'skin_care',
        dosage: '1%',
        manufacturer: 'Cortizone',
        stock: 70,
        rating: 4.2,
        activeIngredient: 'Hydrocortisone',
      ),
      Medicine(
        id: '9',
        name: 'Eye Drops',
        description: 'Relief for dry and irritated eyes',
        price: 90.0,
        imageUrl: 'assets/images/panadol.png',
        category: 'eye_ear',
        dosage: '15ml',
        manufacturer: 'Refresh',
        stock: 55,
        rating: 4.4,
        activeIngredient: 'Carboxymethylcellulose',
      ),
      Medicine(
        id: '10',
        name: 'First Aid Bandages',
        description: 'Sterile adhesive bandages for minor cuts',
        price: 90.0,
        imageUrl: 'assets/images/panadol.png',
        category: 'first_aid',
        dosage: 'Pack of 50',
        manufacturer: 'Band-Aid',
        stock: 200,
        rating: 4.8,
        activeIngredient: 'N/A',
      ),
      Medicine(
        id: '11',
        name: 'Antidepressant',
        description: 'Helps manage depression and anxiety',
        price: 90.0,
        imageUrl: 'assets/images/panadol.png',
        category: 'mental_health',
        dosage: '50mg',
        manufacturer: 'Pfizer',
        stock: 30,
        rating: 4.1,
        activeIngredient: 'Sertraline',
      ),
      Medicine(
        id: '12',
        name: 'Antibiotic Ointment',
        description: 'Prevents infection in minor wounds',
        price: 90.0,
        imageUrl: 'assets/images/panadol.png',
        category: 'first_aid',
        dosage: '30g',
        manufacturer: 'Neosporin',
        stock: 90,
        rating: 4.6,
        activeIngredient: 'Bacitracin',
      ),
    ];
  }
}