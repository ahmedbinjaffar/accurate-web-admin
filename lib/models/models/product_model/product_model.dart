import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.image,
    required this.id,
    required this.name,
    required this.price, // price is now dynamic
    required this.description,
    required this.isFavourite,
    required this.categoryid,
    required this.url,
    this.timestamp,
  });

  String image;
  String id, categoryid;
  bool isFavourite;
  String name;
  dynamic price; // price is now dynamic
  String url;
  String description;
  DateTime? timestamp;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      image: json["image"] ?? "",
      id: json["id"] ?? "",
      url: json["url"] ?? "",
      isFavourite: json["isFavourite"] ?? false,
      name: json["name"] ?? "",
      categoryid: json['categoryid'] ?? "",
      price: json["price"] ?? '', // Handle price as dynamic
      description: json["description"] ?? "",
      timestamp: (json['timestamp'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
        "image": image,
        "id": id,
        "url": url,
        "isFavourite": isFavourite,
        "name": name,
        "price": price, // price as dynamic
        "description": description,
        "categoryid": categoryid,
        "timestamp": timestamp != null
            ? Timestamp.fromDate(timestamp!)
            : FieldValue.serverTimestamp(),
      };

  ProductModel copyWith({
    String? image,
    String? name,
    String? id,
    String? categoryid,
    String? description,
    dynamic price, // Handle price as dynamic
    String? url,
    bool? isFavourite,
    DateTime? timestamp,
  }) =>
      ProductModel(
        id: id ?? this.id,
        image: image ?? this.image,
        name: name ?? this.name,
        categoryid: categoryid ?? this.categoryid,
        isFavourite: isFavourite ?? this.isFavourite,
        price: price ?? this.price,
        description: description ?? this.description,
        url: url ?? this.url,
        timestamp: timestamp ?? this.timestamp,
      );
}
