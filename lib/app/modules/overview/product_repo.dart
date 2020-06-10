import 'package:shopingapp/app/db/products.dart';

import 'product.dart';

class ProductsRepo {
  List<Product> _productsFromDb = [];

  List<Product> getAll() {
    if (products.isNotEmpty && products != null && products.length != 0)
      return [...this._productsFromDb = products];
    return [..._productsFromDb];
  }

  List<Product> getFavorites() {
    return [
      ...this
          ._productsFromDb
          .where((item) => item.get_isFavorite() == true)
          .toList()
    ];
  }

  void toggleFavoriteStatus(String id) {
    Product productFound = getById(id);
    productFound.set_isFavorite(!productFound.get_isFavorite());
  }

  Product getById(String id) {
    return this
        ._productsFromDb
        .firstWhere((productToBeGoten) => productToBeGoten.get_id() == id);
  }

  bool add(Product product) {
    _productsFromDb.add(product);
    return !_productsFromDb
        .indexWhere((prod) => prod.get_id() == product.get_id())
        .isNegative;
  }

  bool update(Product product) {
    final _productFindIndex =
        _productsFromDb.indexWhere((prod) => prod.get_id() == product.get_id());
    if (_productFindIndex >= 0) _productsFromDb[_productFindIndex] = product;
    return !_productsFromDb
        .indexWhere((prod) => prod.get_id() == product.get_id())
        .isNegative;
  }

  void delete(String id) {
    _productsFromDb.removeWhere((element) => element.get_id() == id);
  }
}
