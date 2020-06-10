import 'package:lombok/lombok.dart';
import 'package:shopingapp/app/modules/cart/cart_item.dart';

part 'order.g.dart';

@getter
class Order with _$OrderLombok {
  String _id;
  double _amount;
  List<CartItem> _cartItemsList;
  DateTime _datetime;

  Order(this._id, this._amount, this._cartItemsList, this._datetime);
}
