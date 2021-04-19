import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {

  // Addinng Product is not working , problably, because id is being sending
  // as a NULL
  String id;

  String title, description, imageUrl;
  double price;
  bool isFavorite = false;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.isFavorite,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

// import 'dart:convert';
//
// class Product {
//
//   String id;
//   String title;
//   String description;
//   double price;
//   String imageUrl;
//   bool isFavorite = false;
//
//   Product({
//     this.id,
//     this.title,
//     this.description,
//     this.price,
//     this.imageUrl,
//     this.isFavorite = false,
//   });
//
//   factory Product.from_Json(String str) => Product.fromJson(json.decode(str));
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     id: json["id"] == null ? null : json["id"],
//     title: json["title"] == null ? null : json["title"],
//     description: json["description"] == null ? null : json["description"],
//     price: json["price"] == null ? null : json["price"].toDouble(),
//     imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
//     isFavorite: json["isFavorite"] == null ? null : json["isFavorite"],
//   );
//
//   String to_Json() => json.encode(toJson());
//
//   Map<String, dynamic> toJson() => {
//     "id": id == null ? null : id,
//     "title": title == null ? null : title,
//     "description": description == null ? null : description,
//     "price": price == null ? null : price,
//     "imageUrl": imageUrl == null ? null : imageUrl,
//     "isFavorite": isFavorite == null ? null : isFavorite,
//   };
//
//   factory Product.deepCopy(Product productToCopy) => Product(
//     id:   productToCopy.id,
//     title:   productToCopy.title,
//     description:  productToCopy.description,
//     price: productToCopy.price,
//     imageUrl:  productToCopy.imageUrl,
//     isFavorite: productToCopy.isFavorite,
//   );
// }
