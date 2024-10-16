import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;
  final String image;
  final DateTime? timestamp; // Add this line

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.timestamp, // Add this line
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json, String id) {
    return CategoryModel(
      id: id,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      timestamp: (json['timestamp'] as Timestamp?)
          ?.toDate(), // Convert Firestore Timestamp to DateTime
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'timestamp': timestamp != null
          ? Timestamp.fromDate(timestamp!)
          : FieldValue.serverTimestamp(), // Add this line
    };
  }

  CategoryModel copyWith({
    String? image,
    String? name,
    DateTime? timestamp, // Add this line
  }) =>
      CategoryModel(
        id: id,
        image: image ?? this.image,
        name: name ?? this.name,
        timestamp: timestamp ?? this.timestamp, // Add this line
      );
}
