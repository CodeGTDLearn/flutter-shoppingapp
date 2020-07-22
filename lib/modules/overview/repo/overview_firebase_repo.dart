import '../../../datasource/products_db.dart';
import '../../core/entities/product.dart';
import 'i_overview_repo.dart';

class OverviewFirebaseRepo implements IOverviewRepo {
  List<Product> _products = [];

  @override
  List<Product> getAll() {
    if (productsDb.isNotEmpty &&
        productsDb != null &&
        productsDb.length != 0) {
      return [..._products = productsDb];
    }
    return [..._products];
  }

  @override
  List<Product> getFavorites() {
    return [
      ..._products.where((item) => item.isFavorite == true).toList()
    ];
  }

  @override
  void toggleFavoriteStatus(String id) {
    var productFound = getById(id);
    productFound.isFavorite = !productFound.isFavorite;
  }

  @override
  Product getById(String id) {
    return _products
        .firstWhere((productToBeGoten) => productToBeGoten.id == id);
  }
}

//  @override
//  bool add(Product product) {
//    _products.add(product);
//    return !_products
//        .indexWhere((prod) => prod.id == product.id)
//        .isNegative;
//  }
//
//  @override
//  bool update(Product product) {
//    final _productFindIndex =
//        _products.indexWhere((prod) => prod.id == product.id);
//    if (_productFindIndex >= 0) _products[_productFindIndex] = product;
//    return !_products
//        .indexWhere((prod) => prod.id == product.id)
//        .isNegative;
//  }
//
//  @override
//  void delete(String id) {
//    _products.removeWhere((element) => element.id == id);
//  }
