import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

// flutter pub run build_runner watch
// flutter pub run build_runner build
// flutter pub run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class Product {
  String? id;
  String title;
  String description;
  String imageUrl;
  double price;
  bool isFavorite;
  String code;
  int stockQtde;
  double discount;
  late DateTime arrivalDate;
  late DateTime expirationDate;

  Product({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.stockQtde,
    this.code = "",
    this.isFavorite = false,
    this.discount = 0,
    DateTime? arrivalDate,
    DateTime? expirationDate,
  })  : arrivalDate = arrivalDate ?? DateTime.now(),
        expirationDate = arrivalDate ?? DateTime.now();

  Product.emptyInitialized({
    this.title = '',
    this.description = '',
    this.price = 0.00,
    this.imageUrl = '',
    this.isFavorite = false,
    this.stockQtde = 10,
    this.code = "",
    this.discount = 0,
    final arrivalDate,
    final expirationDate,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}