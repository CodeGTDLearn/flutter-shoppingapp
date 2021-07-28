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

  Order(this.id, this.amount, this.datetime, this.cartItems);

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  factory Order.deepCopy(Order orderToCopy) => Order(
        orderToCopy.id,
        orderToCopy.amount,
        orderToCopy.datetime,
        orderToCopy.cartItems,
      );
}
