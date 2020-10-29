import 'dart:convert';

class Product {
  Product([
    this._id,
    this._title,
    this._description,
    this._price,
    this._imageUrl,
    this._isFavorite = false,
  ]);

  String _id;
  String _title;
  String _description;
  double _price;
  String _imageUrl;
  bool _isFavorite = false;

  factory Product.from_Json(String str) => Product.fromJson(json.decode(str));

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        json["id"] == null ? null : json["id"],
        json["title"] == null ? null : json["title"],
        json["description"] == null ? null : json["description"],
        json["price"] == null ? null : json["price"].toDouble(),
        json["imageUrl"] == null ? null : json["imageUrl"],
        json["isFavorite"] == null ? null : json["isFavorite"],
      );

  String to_Json() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "price": price == null ? null : price,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "isFavorite": isFavorite == null ? null : isFavorite,
      };

  factory Product.deepCopy(Product productToCopy) => Product(
        productToCopy.id,
        productToCopy.title,
        productToCopy.description,
        productToCopy.price,
        productToCopy.imageUrl,
        productToCopy.isFavorite,
      );

  String get id => _id;

  set id(String value) => _id = value;

  bool get isFavorite => _isFavorite;

  set isFavorite(bool value) => _isFavorite = value;

  String get imageUrl => _imageUrl;

  set imageUrl(String value) => _imageUrl = value;

  double get price => _price;

  set price(double value) => _price = value;

  String get description => _description;

  set description(String value) => _description = value;

  String get title => _title;

  set title(String value) => _title = value;
}
