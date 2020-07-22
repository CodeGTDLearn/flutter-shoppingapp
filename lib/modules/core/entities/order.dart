import 'package:lombok/lombok.dart';

import 'cart_item.dart';

part 'order.g.dart';

@getter
class Order with _$OrderLombok {

  String id;
  String amount;
  List<CartItem> cartItemsList;
  String datetime;

  Order({
    this.id,
    this.amount,
    this.cartItemsList,
    this.datetime,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        amount: json["amount"],
        cartItemsList: List<dynamic>.from(json["cartItemsList"].map((x) => x)),
        datetime: json["datetime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "cartItemsList": List<dynamic>.from(cartItemsList.map((x) => x)),
        "datetime": datetime,
      };
}