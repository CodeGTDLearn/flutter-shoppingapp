import 'package:shopingapp/entities_models/cart_item.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> cartItemsList;
  final DateTime datetime;

  Order(this.id, this.amount, this.cartItemsList, this.datetime);
}
