import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

//PROBLEMA DE NULL SAFETY DEVE SER RESOLVIDOR
// Generator cannot target libraries that have not been migrated to null-safety.
// package:shopingapp/app/modules/inventory/entities/product.dart:7:7
//   ╷
// 7 │ class Product {
//   │       ^^^^^^^
//   ╵

//flutter pub run build_runner watch
//flutter pub run build_runner build
@JsonSerializable()
class Product {
  String id;
  String title;
  String description;
  String imageUrl;
  double price;
  bool isFavorite;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
