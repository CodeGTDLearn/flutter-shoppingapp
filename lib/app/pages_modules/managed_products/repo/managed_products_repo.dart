import 'dart:convert';

import 'package:http/http.dart' as connect;

import '../../../core/properties/app_properties.dart';
import '../entities/product.dart';
import 'i_managed_products_repo.dart';

class ManagedProductsRepo implements IManagedProductsRepo {
  final List<Product> _products = [];

  @override
  Future<List<Product>> getAllManagedProducts() {
    // @formatter:off
    var _AllProducts = <Product>[];

    return connect
        .get(PRODUCTS_URL)
        .then((jsonResponse) {
            final MapDecodedFromJsonResponse =
              json.decode(jsonResponse.body) as Map<String, dynamic>;

      MapDecodedFromJsonResponse
          .forEach((idMap, dataMap) {
            //print(dataMap['title'].toString());
            var productObjectCreatedFromDataMap = Product.fromJson(dataMap);

            _AllProducts.add(productObjectCreatedFromDataMap);
            //print(">>>>>>> ${productObjectCreatedFromDataMap.title}");
      });
      return _AllProducts;
    }).catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  int getManagedProductsQtde() {
    int productsQtde;
    getAllManagedProducts().then((value) {
      productsQtde = value.length;
    });
    return productsQtde;
  }

  @override
  Product getById(String id) {
    return _products
        .firstWhere((productToBeGoten) => productToBeGoten.id == id);
  }

  @override
  Future<void> addProduct(Product product) {
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
