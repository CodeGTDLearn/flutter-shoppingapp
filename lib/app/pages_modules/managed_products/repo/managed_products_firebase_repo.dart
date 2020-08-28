import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/properties/app_properties.dart';
import '../entities/product.dart';
import 'i_managed_products_repo.dart';

class ManagedProductsRepo implements IManagedProductsRepo {
  List<Product> _dataSavingProducts = [];

  List<Product> get dataSavingProducts => _dataSavingProducts;

  @override
  Future<List<Product>> getProducts() {
    // @formatter:off
    return http
        .get(PRODUCTS_URL)
        .then((jsonResponse) {
        var _gottenProducts = <Product>[];
        final MapDecodedFromJsonResponse =
        json.decode(jsonResponse.body) as Map<String, dynamic>;

        MapDecodedFromJsonResponse != null ?
        MapDecodedFromJsonResponse
          .forEach((idMap, dataMap) {
        //print(dataMap['title'].toString());
            var productObjectCreatedFromDataMap = Product.fromJson(dataMap);
            productObjectCreatedFromDataMap.id = idMap;
            _gottenProducts.add(productObjectCreatedFromDataMap);
        })
            :_gottenProducts = [];

        clearDataSavingLists();

        _dataSavingProducts = _gottenProducts;

        _orderDataSavingLists();

        return _gottenProducts;
    }).catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  Product getProductById(String id) {
    var _index = _dataSavingProducts.indexWhere((item) => item.id == id);
    return _dataSavingProducts[_index];
  }

  @override
  Future<void> saveProduct(Product productSaved) {
    // @formatter:off
    return http
        .post(PRODUCTS_URL, body: productSaved.to_Json())
        .then((response) {
            productSaved.id = json.decode(response.body)['name'];
            _dataSavingProducts.add(productSaved);
            return response.statusCode;
        })
        .catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  Future<void> updateProduct(Product productUpdated) {
    // @formatter:off
    final _index =
    _dataSavingProducts.indexWhere((item) => item.id == productUpdated.id);

    return http
        .patch("$BASE_URL/$COLLECTION_PRODUCTS/${productUpdated.id}.json", body:
            productUpdated.to_Json())
        .then((response) {
            if (response.statusCode >= 200 && response.statusCode >= 299) {
                  _dataSavingProducts[_index] = productUpdated;
            }
    }); //there is no catchError in delete and update;
    // @formatter:on
  }

  @override
  Future<int> deleteProduct(String id) {
    final _index = _dataSavingProducts.indexWhere((item) =>
    item.id == id);

    return http
        .delete("$BASE_URL/$COLLECTION_PRODUCTS/$id.json")
        .then((response) {
      if (response.statusCode >= 200 && response.statusCode >= 299) {
        _dataSavingProducts.removeAt(_index);
      }
      return response.statusCode;
    }); //there is no catchError in delete and update;
  }

  @override
  void clearDataSavingLists() {
    _dataSavingProducts = [];
  }

  void _orderDataSavingLists() {
    _dataSavingProducts.toList().sort;
  }
}
//  Future<Product> getManagedProductById(String id) {
    // @formatter:off
//    Product productObjectCreatedFromDataMap;

//    return http.get(PRODUCTS_URL)
//        .then((jsonResponse) {
//          final MapDecodedFromJsonResponse =
//          json.decode(jsonResponse.body) as Map<String, dynamic>;
//
//          MapDecodedFromJsonResponse
//          .forEach((idMap, dataMap) {
//            if(idMap == id){
//              productObjectCreatedFromDataMap = Product.fromJson(dataMap);
//              productObjectCreatedFromDataMap.id = idMap;
//            }
//          });
//          return productObjectCreatedFromDataMap;
//        }).catchError((onError) => throw onError);
    // @formatter:on
  // @override
  // Future<List<Product>> getProducts() {
  //   var _rollbackList = _dataSavingProducts;
  //   _dataSavingProducts = [];
  //
  //   // @formatter:off
  //   return http.get(PRODUCTS_URL)
  //       .then((jsonResponse) {
  //           final MapDecodedFromJsonResponse =
  //             json.decode(jsonResponse.body) as Map<String, dynamic>;
  //
  //         MapDecodedFromJsonResponse
  //         .forEach((idMap, dataMap) {
  //
  //           var productObjectCreatedFromDataMap = Product.fromJson(dataMap);
  //           productObjectCreatedFromDataMap.id = idMap.toString();
  //
  //           _dataSavingProducts.add(productObjectCreatedFromDataMap);
  //     });
  //     return _dataSavingProducts;
  //   }).catchError((onError){
  //     _dataSavingProducts = _rollbackList;
  //   });
  //   // @formatter:on
  // }
