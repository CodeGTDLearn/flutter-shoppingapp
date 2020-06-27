import 'package:lombok/lombok.dart';

part 'cart_item.g.dart';

@getter
//class CartItem with _$CartItemLombok {
class CartItem with _$CartItemLombok {
  final String _id;
  final String _title;
  final int _qtde;
  final double _price;

  CartItem(this._id, this._title, this._qtde, this._price);
}
