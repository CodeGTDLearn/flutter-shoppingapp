class CartItem {
  String _id;
  String _title;
  int _qtde;
  double _price;

  CartItem(this._id, this._title, this._qtde, this._price);

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  int get qtde => _qtde;

  set qtde(int value) {
    _qtde = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}
