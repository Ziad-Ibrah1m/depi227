import '../models/pharmacy.dart';

class PharmacyRepository {
  // Mock pharmacy data - replace with actual API call
  Future<List<Pharmacy>> getAllPharmacies() async {
    return [
      Pharmacy(
        id: '1',
        name: 'Pharmacy',
        location: 'Sidi Basher , Alex...',
        address: 'Sidi Basher, Alexandria, Egypt',
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
        address: 'Sidi Basher, Alexandria, Egypt',
        phoneNumber: '010 0000 0000',
        whatsappNumber: '010 0000 0000',
        imageUrl: 'assets/images/pharmacy_placeholder.jpg',
        rating: 4.3,
        isOpen: true,
      ),
    ];
  }
}