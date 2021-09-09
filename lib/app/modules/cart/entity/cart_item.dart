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

// factory CartItem.from_Json(String str) => CartItem.fromJson(json.decode(str));
//
// String to_Json() => json.encode(toJson());
//
// factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
//       json["id"] == null ? null : json["id"],
//       json["title"] == null ? null : json["title"],
//       json["qtde"] == null ? null : json["qtde"],
//       json["price"] == null ? null : json["price"].toDouble(),
//     );
//
// Map<String, dynamic> toJson() => {
//       "id": id == null ? null : id,
//       "title": title == null ? null : title,
//       "qtde": qtde == null ? null : qtde,
//       "price": price == null ? null : price,
//     };
}
