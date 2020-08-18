import 'dart:convert';

class Product {
  Product([
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.isFavorite = false,
  ]);

  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  bool isFavorite;

  factory Product.from_Json(String str) => Product.fromJson(json.decode(str));

  String to_Json() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        json["id"] == null ? null : json["id"],
        json["title"] == null ? null : json["title"],
        json["description"] == null ? null : json["description"],
        json["price"] == null ? null : json["price"].toDouble(),
        json["imageUrl"] == null ? null : json["imageUrl"],
        json["isFavorite"] == null ? null : json["isFavorite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "price": price == null ? null : price,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "isFavorite": isFavorite == null ? null : isFavorite,
      };
}
