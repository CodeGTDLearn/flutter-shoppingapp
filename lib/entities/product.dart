import 'package:lombok/lombok.dart';

part 'product.g.dart';

@data
class Product with _$ProductLombok {

  String _id;
  String _title;
  String _description;
  double _price;
  String _imageUrl;
  bool _isFavorite = false;

  Product([this._id, this._title, this._description, this._price, this._imageUrl,
      this._isFavorite = false]);
}