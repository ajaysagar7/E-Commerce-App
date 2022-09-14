// To parse this JSON data, do
//
//     final apiModel = apiModelFromJson(jsonString);

import 'dart:convert';

List<ApiModel> apiModelFromJson(String str) =>
    List<ApiModel>.from(json.decode(str).map((x) => ApiModel.fromJson(x)));

String apiModelToJson(List<ApiModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApiModel {
  ApiModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });

  dynamic id;
  String title;
  dynamic price;
  String description;
  Category category;
  List<String> images;

  factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
        id: json["id"] as dynamic,
        title: json["title"] as String,
        price: json["price"] as dynamic,
        description: json["description"] as String,
        category: Category.fromJson(json["category"]),
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category.toJson(),
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  dynamic id;
  String name;
  String image;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] as dynamic,
        name: json["name"] as String,
        image: json["image"] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
