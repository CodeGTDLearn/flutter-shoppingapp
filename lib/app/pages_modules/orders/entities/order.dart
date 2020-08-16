import '../../cart/entities/cart_item.dart';

class Order {
  final String id;
  final String amount;
  final List<CartItem> cartItemsList;
  final String datetime;

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