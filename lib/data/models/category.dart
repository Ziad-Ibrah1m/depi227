import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String iconPath;
  final Color color;

  Category({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.color,
  });

  // Create Category from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      iconPath: json['iconPath'],
      color: Color(json['color']),
    );
  }

  // Convert Category to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconPath': iconPath,
      'color': color.value,
    };
  }

  // Create a copy with modified fields
  Category copyWith({
    String? id,
    String? name,
    String? iconPath,
    Color? color,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      iconPath: iconPath ?? this.iconPath,
      color: color ?? this.color,
    );
  }
}