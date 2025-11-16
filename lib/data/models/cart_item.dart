import 'medicine.dart';

class CartItem {
  final String id;
  final Medicine medicine;
  int quantity;
  final DateTime addedAt;

  CartItem({
    required this.id,
    required this.medicine,
    required this.quantity,
    required this.addedAt,
  });

  // Calculate total price for this cart item
  double get totalPrice => medicine.price * quantity;

  // Create CartItem from JSON
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      medicine: Medicine.fromJson(json['medicine']),
      quantity: json['quantity'],
      addedAt: DateTime.parse(json['addedAt']),
    );
  }

  // Convert CartItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medicine': medicine.toJson(),
      'quantity': quantity,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  // Create a copy with modified fields
  CartItem copyWith({
    String? id,
    Medicine? medicine,
    int? quantity,
    DateTime? addedAt,
  }) {
    return CartItem(
      id: id ?? this.id,
      medicine: medicine ?? this.medicine,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
    );
  }
}
