import 'dart:convert';

BannerModel calendarModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String youtubeModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  BannerModel({
    required this.image,
    required this.id,
    //required this.name,
  });

  String image;
  String id;
  //String name;

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      image: json["image"] ?? "",
      id: json["id"] ?? "",
      //name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "image": image,
        "id": id,
        //"name": name,
      };
  BannerModel copyWith({
    String? image,
    String? id,
  }) =>
      BannerModel(
        id: id ?? this.id,
        image: image ?? this.image,
      );
}
