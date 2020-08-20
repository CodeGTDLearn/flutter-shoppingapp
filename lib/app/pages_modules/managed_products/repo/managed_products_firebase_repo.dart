import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/properties/app_properties.dart';
import '../entities/product.dart';
import 'i_managed_products_repo.dart';

class ManagedProductsRepo implements IManagedProductsRepo {
  List<Product> _optmisticListProducts = [];

  @override
  Future<List<Product>> getAllManagedProducts() {
    _optmisticListProducts = [];
    // @formatter:off
    return http.get(PRODUCTS_URL)
        .then((jsonResponse) {
            final MapDecodedFromJsonResponse =
              json.decode(jsonResponse.body) as Map<String, dynamic>;

          MapDecodedFromJsonResponse
          .forEach((idMap, dataMap) {

            var productObjectCreatedFromDataMap = Product.fromJson(dataMap);
            productObjectCreatedFromDataMap.id = idMap.toString();

            _optmisticListProducts.add(productObjectCreatedFromDataMap);
            //print(">>>>>>> ${productObjectCreatedFromDataMap.title}");
      });
      return _optmisticListProducts;
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
  Future<Product> getManagedProductById(String id) {
    // @formatter:off
    Product productObjectCreatedFromDataMap;

    return http.get(PRODUCTS_URL)
        .then((jsonResponse) {
          final MapDecodedFromJsonResponse =
          json.decode(jsonResponse.body) as Map<String, dynamic>;

          MapDecodedFromJsonResponse
          .forEach((idMap, dataMap) {
            if(idMap == id){
              productObjectCreatedFromDataMap = Product.fromJson(dataMap);
              productObjectCreatedFromDataMap.id = idMap;
            }
          });
          return productObjectCreatedFromDataMap;
        }).catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  Future<void> saveManagedProduct(Product product) {
    // @formatter:off
    return http
        .post(PRODUCTS_URL, body: product.to_Json())
        .then((response) {
            product.id = json.decode(response.body)['name'];
            _optmisticListProducts.add(product);
            return response.statusCode;
        })
        .catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  Future<void> updateManagedProduct(Product product) {
    // @formatter:off
    final _optmisticProductIndex =
    _optmisticListProducts.indexWhere((indexProduct) => indexProduct.id == product.id);
    return http
        .patch("$PRODUCTS_URL/${product.id}", body: product.to_Json())
        .then((response) {
            _optmisticListProducts[_optmisticProductIndex] = product;
            return response.statusCode;
    })
    .catchError((onError) => throw onError);
    // @formatter:on

    //final _productFindIndex =
    //    _products.indexWhere((prod) => prod.id == product.id);
    //if (_productFindIndex >= 0) _products[_productFindIndex] = product;
    //return !_products.indexWhere((prod) => prod.id == product.id).isNegative;
  }

  @override
  void deleteManagedProduct(String id) {
    _optmisticListProducts.removeWhere((element) => element.id == id);
  }
}

//bool updateManagedProduct(Product product) {
//  final _productFindIndex =
//  _products.indexWhere((prod) => prod.id == product.id);
//  if (_productFindIndex >= 0) _products[_productFindIndex] = product;
//  return !_products.indexWhere((prod) => prod.id == product.id).isNegative;
//}
