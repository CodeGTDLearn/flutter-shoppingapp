import 'dart:convert';

import '../../cart/entities/cart_item.dart';

class Order {
  Order([
    this.amount,
    this.datetime,
    this.cartItems,
    this.id,
  ]);

  String id;
  String amount;
  String datetime;
  List<CartItem> cartItems;

  factory Order.from_Json(String str) => Order.fromJson(json.decode(str));

  String to_Json() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        json["amount"] == null ? null : json["amount"],
        json["datetime"] == null ? null : json["datetime"],
        json["cartItems"] == null
            ? null
            : List<CartItem>.from(
                json["cartItems"].map((x) => CartItem.fromJson(x))),
        json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "amount": amount == null ? null : amount,
        "datetime": datetime == null ? null : datetime,
        "cartItems": cartItems == null
            ? null
            : List<dynamic>.from(cartItems.map((x) => x.toJson())),
      };

  factory Order.deepCopy(Order orderToCopy) => Order(
        orderToCopy.amount,
        orderToCopy.datetime,
        orderToCopy.cartItems,
        orderToCopy.id,
      );
}
