import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/properties/app_properties.dart';
import '../entities/product.dart';
import 'i_managed_products_repo.dart';

class ManagedProductsRepo implements IManagedProductsRepo {
  List<Product> _optmisticList = [];

  @override
  Future<List<Product>> getAllManagedProducts() {
    _optmisticList = [];
    // @formatter:off
    return http.get(PRODUCTS_URL)
        .then((jsonResponse) {
            final MapDecodedFromJsonResponse =
              json.decode(jsonResponse.body) as Map<String, dynamic>;

          MapDecodedFromJsonResponse
          .forEach((idMap, dataMap) {

            var productObjectCreatedFromDataMap = Product.fromJson(dataMap);
            productObjectCreatedFromDataMap.id = idMap.toString();

            _optmisticList.add(productObjectCreatedFromDataMap);
            //print(">>>>>>> ${productObjectCreatedFromDataMap.title}");
      });
      return _optmisticList;
    }).catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  List<Product> getAllManagedProductsOptmistic() {
    return _optmisticList;
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
  Future<void> saveManagedProduct(Product productSaved) {
    // @formatter:off
    return http
        .post(PRODUCTS_URL, body: productSaved.to_Json())
        .then((response) {
            productSaved.id = json.decode(response.body)['name'];
            _optmisticList.add(productSaved);
            return response.statusCode;
        })
        .catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  Future<void> updateManagedProduct(Product productUpdated) {
    // @formatter:off
    final _index =
    _optmisticList.indexWhere((item) => item.id == productUpdated.id);

    return http
        .patch("$BASE_URL/$COLLECTION_PRODUCTS/${productUpdated.id}.json", body:
    productUpdated.to_Json())
        .then((response) {
      if (_index >= 0)_optmisticList[_index] = productUpdated;
    })
    .catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  void deleteManagedProduct(String id) {
    _optmisticList.removeWhere((element) => element.id == id);
  }
}
