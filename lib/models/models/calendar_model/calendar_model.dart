import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

PricingModel pricingModelFromJson(String str) =>
    PricingModel.fromJson(json.decode(str));

String pricingModelToJson(PricingModel data) => json.encode(data.toJson());

class PricingModel {
  PricingModel({
    required this.image,
    required this.id,
    this.timestamp, // Add this line for the timestamp
  });

  String image;
  String id;
  DateTime? timestamp; // Add this line for the timestamp

  factory PricingModel.fromJson(Map<String, dynamic> json) {
    return PricingModel(
      image: json["image"] ?? "",
      id: json["id"] ?? "",
      timestamp:
          (json['timestamp'] as Timestamp?)?.toDate(), // Handle timestamp
    );
  }

  Map<String, dynamic> toJson() => {
        "image": image,
        "id": id,
        "timestamp": timestamp != null
            ? Timestamp.fromDate(timestamp!)
            : FieldValue.serverTimestamp(), // Handle timestamp
      };

  PricingModel copyWith({
    String? image,
    String? id,
    DateTime? timestamp, // Add this line for copying timestamp
  }) =>
      PricingModel(
        id: id ?? this.id,
        image: image ?? this.image,
        timestamp: timestamp ?? this.timestamp, // Ensure timestamp is copied
      );
}
