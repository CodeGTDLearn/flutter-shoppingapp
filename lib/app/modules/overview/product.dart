import 'package:lombok/lombok.dart';

part 'product.g.dart';

@data
class Product with _$ProductLombok {
  // ignore: prefer_final_fields
  String _id; // ignore: prefer_final_fields
  String _title; // ignore: prefer_final_fields
  String _description; // ignore: prefer_final_fields
  double _price; // ignore: prefer_final_fields
  String _imageUrl; // ignore: prefer_final_fields
  bool _isFavorite = false; // ignore: prefer_final_fields

  Product(
      [this._id,
      this._title,
      this._description,
      this._price,
      this._imageUrl,
      // ignore: avoid_positional_boolean_parameters
      this._isFavorite = false]);
}
