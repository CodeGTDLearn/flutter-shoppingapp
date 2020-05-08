import 'package:lombok/lombok.dart';

part 'CartItem.g.dart';

@getter
class CartItem with _$CartItemLombok   {

  String _id;
  String _title;
  int _qtde;
  double _price;

  CartItem(this._id, this._title, this._qtde, this._price);
}
