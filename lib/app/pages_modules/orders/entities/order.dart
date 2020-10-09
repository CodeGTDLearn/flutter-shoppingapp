import 'dart:convert';

import '../../cart/entities/cart_item.dart';

class Order {
  Order([
    this._id,
    this._amount,
    this._datetime,
    this._cartItemsList,
  ]);

  String _id;
  String _amount;
  String _datetime;
  List<CartItem> _cartItemsList;

  factory Order.from_Json(String str) => Order.fromJson(json.decode(str));

  String to_Json() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        json["id"] == null ? null : json["id"],
        json["amount"] == null ? null : json["amount"],
        json["datetime"] == null ? null : json["datetime"],
        json["cartItemsList"] == null
            ? null
            : List<CartItem>.from(json["cartItemsList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": _id == null ? null : _id,
        "amount": _amount == null ? null : _amount,
        "datetime": _datetime == null ? null : _datetime,
        "cartItemsList": _cartItemsList == null
            ? null
            : List<dynamic>.from(_cartItemsList.map((x) => x)),
      };

  factory Order.deepCopy(Order orderToCopy) => Order(
        orderToCopy._id,
        orderToCopy._amount,
        orderToCopy._datetime,
        orderToCopy._cartItemsList,
      );

  List<CartItem> get cartItemsList => _cartItemsList;

  set cartItemsList(List<CartItem> value) {
    _cartItemsList = value;
  }

  String get datetime => _datetime;

  set datetime(String value) {
    _datetime = value;
  }

  String get amount => _amount;

  set amount(String value) {
    _amount = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}

// class Order {
//   Order({
//     this.id,
//     this.amount,
//     this.cartItemsList,
//     this.datetime,
//   });
//
//   final String id;
//   final String amount;
//   final List<CartItem> cartItemsList;
//   final String datetime;
//
//
//   factory Order.fromJson(Map<String, dynamic> json) => Order(
//         id: json["id"],
//         amount: json["amount"],
//         cartItemsList: List<dynamic>.from(json["cartItemsList"].map((x) => x)),
//         datetime: json["datetime"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "amount": amount,
//         "cartItemsList": List<dynamic>.from(cartItemsList.map((x) => x)),
//         "datetime": datetime,
//       };
// }
