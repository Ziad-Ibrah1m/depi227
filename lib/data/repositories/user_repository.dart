import '../models/user.dart';
import '../services/firestore_service.dart';

class UserRepository {
  final FirestoreService _firestoreService = FirestoreService();

  Future<User?> getUser(String userId) async {
    return await _firestoreService.getUser(userId);
  }

  Future<void> createUser(User user) async {
    await _firestoreService.createUser(user);
  }

  Future<void> updateUser(User user) async {
    await _firestoreService.updateUser(user);
  }
}