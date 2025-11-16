class Pharmacy {
  final String id;
  final String name;
  final String location;
  final String address;
  final String phoneNumber;
  final String whatsappNumber;
  final String imageUrl;
  final double? latitude;
  final double? longitude;
  final double rating;
  final bool isOpen;

  Pharmacy({
    required this.id,
    required this.name,
    required this.location,
    required this.address,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.imageUrl,
    this.latitude,
    this.longitude,
    this.rating = 0.0,
    this.isOpen = true,
  });

  // Create Pharmacy from JSON
  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      whatsappNumber: json['whatsappNumber'],
      imageUrl: json['imageUrl'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      isOpen: json['isOpen'] ?? true,
    );
  }

  // Convert Pharmacy to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'address': address,
      'phoneNumber': phoneNumber,
      'whatsappNumber': whatsappNumber,
      'imageUrl': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
      'rating': rating,
      'isOpen': isOpen,
    };
  }

  // Create a copy with modified fields
  Pharmacy copyWith({
    String? id,
    String? name,
    String? location,
    String? address,
    String? phoneNumber,
    String? whatsappNumber,
    String? imageUrl,
    double? latitude,
    double? longitude,
    double? rating,
    bool? isOpen,
  }) {
    return Pharmacy(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      rating: rating ?? this.rating,
      isOpen: isOpen ?? this.isOpen,
    );
  }
}
