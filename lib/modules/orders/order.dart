import '../cart/cart_item.dart';

part 'order.g.dart';

class Order with _$OrderLombok {
  final String _id;
  final double _amount;
  final List<CartItem> _cartItemsList;
  final DateTime _datetime;

  Order(this._id, this._amount, this._cartItemsList, this._datetime);
}
