import 'package:json_annotation/json_annotation.dart';

part 'cart_item.g.dart';

// flutter pub run build_runner watch
// flutter pub run build_runner build
// flutter pub run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class CartItem {
  String id;
  String title;
  int qtde;
  double price;

  CartItem(
    this.id,
    this.title,
    this.qtde,
    this.price,
  );

  factory CartItem.fromJson(Map<String, dynamic> json) => _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
