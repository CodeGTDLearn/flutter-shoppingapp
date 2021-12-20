import 'package:json_annotation/json_annotation.dart';

import '../../cart/entity/cart_item.dart';

part 'order.g.dart';

// flutter pub run build_runner watch
// flutter pub run build_runner build
// flutter pub run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class Order {
  String? id;
  late String amount;
  late String datetime;
  late List<CartItem> cartItems;

  Order({this.id, required this.amount, required this.datetime, required this.cartItems});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  factory Order.deepCopy(Order orderToCopy) => Order(
        id: orderToCopy.id,
    amount: orderToCopy.amount,
    datetime: orderToCopy.datetime,
    cartItems: orderToCopy.cartItems,
      );
}