import 'dart:convert';

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

  factory CartItem.from_Json(String str) => CartItem.fromJson(json.decode(str));

  String to_Json() => json.encode(toJson());

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        json["id"] == null ? null : json["id"],
        json["title"] == null ? null : json["title"],
        json["qtde"] == null ? null : json["qtde"],
        json["price"] == null ? null : json["price"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "qtde": qtde == null ? null : qtde,
        "price": price == null ? null : price,
      };
}
