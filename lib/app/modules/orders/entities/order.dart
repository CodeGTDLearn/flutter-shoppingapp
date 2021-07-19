import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../cart/entities/cart_item.dart';

part 'order.g.dart';

//flutter pub run build_runner watch
//flutter pub run build_runner build
@JsonSerializable()
class Order {
  String? id;
  late String amount;
  late String datetime;
  late List<CartItem> cartItems;

  Order(
    this.id,
    this.amount,
    this.datetime,
    this.cartItems,
  );

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  // factory Order.from_Json(String str) => Order.fromJson(json.decode(str));
  //
  // String to_Json() => json.encode(toJson());
  //
  // factory Order.fromJson(Map<String, dynamic> json) => Order(
  //       json["amount"] == null ? null : json["amount"],
  //       json["datetime"] == null ? null : json["datetime"],
  //       json["cartItems"] == null
  //           ? null
  //           : List<CartItem>.from(json["cartItems"].map((x) => CartItem.fromJson(x))),
  //       json["id"] == null ? null : json["id"],
  //     );
  //
  // Map<String, dynamic> toJson() => {
  //       "id": id == null ? null : id,
  //       "amount": amount == null ? null : amount,
  //       "datetime": datetime == null ? null : datetime,
  //       "cartItems": cartItems == null
  //           ? null
  //           : List<dynamic>.from(cartItems.map((x) => x.toJson())),
  //     };

  factory Order.deepCopy(Order orderToCopy) => Order(
        orderToCopy.id,
        orderToCopy.amount,
        orderToCopy.datetime,
        orderToCopy.cartItems,
      );
}
