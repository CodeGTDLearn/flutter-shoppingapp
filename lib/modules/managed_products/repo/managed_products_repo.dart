import 'dart:convert';

import 'package:http/http.dart' as connect;

import '../../../core/configurable/app_properties.dart';
import '../entities/product.dart';
import 'i_managed_products_repo.dart';

class ManagedProductsRepo implements IManagedProductsRepo {
  final List<Product> _products = [];

  @override
  List<Product> getAll() {
    return _products;
  }

  @override
  Product getById(String id) {
    return _products
        .firstWhere((productToBeGoten) => productToBeGoten.id == id);
  }

  @override
  Future<void> add(Product product) {
    // @formatter:off
    return connect
        .post(PRODUCTS_URL, body: product.to_Json())
        .then((response) {
            product.id = json.decode(response.body)['name'];
            _products.add(product);
            return response.statusCode;
        })
        .catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  bool update(Product product) {
    final _productFindIndex =
        _products.indexWhere((prod) => prod.id == product.id);
    if (_productFindIndex >= 0) _products[_productFindIndex] = product;
    return !_products.indexWhere((prod) => prod.id == product.id).isNegative;
  }

  @override
  void delete(String id) {
    _products.removeWhere((element) => element.id == id);
  }
}
