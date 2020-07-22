import 'package:get/get.dart';

import '../../core/configurable/app_properties.dart';
import '../../core/connection/custom_dio.dart';
import '../../core/entities/product.dart';
import 'i_managed_products_repo.dart';
import 'package:http/http.dart' as connect;
import 'dart:convert';

class ManagedProductsRepo implements IManagedProductsRepo {
  List<Product> _products = [];

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
  Future<void> add(Product productToAdd) {
    connect.post(PRODUCTS_URL, body: productToAdd.to_Json())
        .then((response) {
      productToAdd.id = json.decode(response.body)['name'];
      _products.add(productToAdd);
    }).catchError((onError) {
      print(onError);
      throw onError;
    });
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
