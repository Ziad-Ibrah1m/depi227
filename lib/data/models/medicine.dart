class Medicine {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final String? dosage;
  final String? manufacturer;
  final int stock;
  final double rating;
  final String? activeIngredient;

  Medicine({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.dosage,
    this.manufacturer,
    required this.stock,
    this.rating = 0.0,
    this.activeIngredient,
  });

  // Create Medicine from JSON
  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      category: json['category'] ?? '',
      dosage: json['dosage'],
      manufacturer: json['manufacturer'],
      stock: json['stock'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      activeIngredient: json['activeIngredient'],
    );
  }

  // Convert Medicine to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'dosage': dosage,
      'manufacturer': manufacturer,
      'stock': stock,
      'rating': rating,
      'activeIngredient': activeIngredient,
    };
  }

  // Create a copy with modified fields
  Medicine copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
    String? dosage,
    String? manufacturer,
    int? stock,
    double? rating,
    String? activeIngredient,
  }) {
    return Medicine(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      dosage: dosage ?? this.dosage,
      manufacturer: manufacturer ?? this.manufacturer,
      stock: stock ?? this.stock,
      rating: rating ?? this.rating,
      activeIngredient: activeIngredient ?? this.activeIngredient,
    );
  }
}