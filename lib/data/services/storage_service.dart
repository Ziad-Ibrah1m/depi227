import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload user profile image
  Future<String?> uploadProfileImage(String userId, File imageFile) async {
    try {
      final ref = _storage.ref().child('users/$userId/profile.jpg');
      final uploadTask = await ref.putFile(imageFile);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  // Delete user profile image
  Future<void> deleteProfileImage(String userId) async {
    try {
      final ref = _storage.ref().child('users/$userId/profile.jpg');
      await ref.delete();
    } catch (e) {
      print('Error deleting image: $e');
    }
  }

  // Upload medicine image (for admin functionality)
  Future<String?> uploadMedicineImage(String medicineId, File imageFile) async {
    try {
      final ref = _storage.ref().child('medicines/$medicineId.jpg');
      final uploadTask = await ref.putFile(imageFile);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading medicine image: $e');
      return null;
    }
  }

  // Delete medicine image
  Future<void> deleteMedicineImage(String medicineId) async {
    try {
      final ref = _storage.ref().child('medicines/$medicineId.jpg');
      await ref.delete();
    } catch (e) {
      print('Error deleting medicine image: $e');
    }
  }
}