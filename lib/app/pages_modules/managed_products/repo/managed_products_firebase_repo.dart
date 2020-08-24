import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/properties/app_properties.dart';
import '../entities/product.dart';
import 'i_managed_products_repo.dart';

class ManagedProductsRepo implements IManagedProductsRepo {
  List<Product> _dataSavingManagedProductsList = [];

  List<Product> get localList => _dataSavingManagedProductsList;

  @override
  Future<List<Product>> getAllManagedProducts() {
    var _rollbackList = _dataSavingManagedProductsList;
    _dataSavingManagedProductsList = [];

    // @formatter:off
    return http.get(PRODUCTS_URL)
        .then((jsonResponse) {
            final MapDecodedFromJsonResponse =
              json.decode(jsonResponse.body) as Map<String, dynamic>;

          MapDecodedFromJsonResponse
          .forEach((idMap, dataMap) {

            var productObjectCreatedFromDataMap = Product.fromJson(dataMap);
            productObjectCreatedFromDataMap.id = idMap.toString();

            _dataSavingManagedProductsList.add(productObjectCreatedFromDataMap);
            //print(">>>>>>> ${productObjectCreatedFromDataMap.title}");
      });
      return _dataSavingManagedProductsList;
    }).catchError((onError){
      _dataSavingManagedProductsList = _rollbackList;
    });
    // @formatter:on
  }

  @override
  Product getManagedProductById(String id) {
    var _index =
        _dataSavingManagedProductsList.indexWhere((item) => item.id == id);
    return _dataSavingManagedProductsList[_index];

  }

  @override
  Future<void> saveManagedProduct(Product productSaved) {
    // @formatter:off
    return http
        .post(PRODUCTS_URL, body: productSaved.to_Json())
        .then((response) {
            productSaved.id = json.decode(response.body)['name'];
            _dataSavingManagedProductsList.add(productSaved);
            return response.statusCode;
        })
        .catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  Future<void> updateManagedProduct(Product productUpdated) {
    // @formatter:off
    final _index =
    _dataSavingManagedProductsList.indexWhere((item) => item.id == productUpdated.id);

    return http
        .patch("$BASE_URL/$COLLECTION_PRODUCTS/${productUpdated.id}.json", body:
            productUpdated.to_Json())
        .then((response) {
            if (response.statusCode >= 200 && response.statusCode >= 299) {
                  _dataSavingManagedProductsList[_index] = productUpdated;
            }
    }); //there is no catchError in delete and update;
    // @formatter:on
  }

  @override
  Future<int> deleteManagedProduct(String id) {
    final _index = _dataSavingManagedProductsList.indexWhere((item) =>
    item.id == id);

    return http
        .delete("$BASE_URL/$COLLECTION_PRODUCTS/$id.json")
        .then((response) {
      if (response.statusCode >= 200 && response.statusCode >= 299) {
        _dataSavingManagedProductsList.removeAt(_index);
      }
      return response.statusCode;
    }); //there is no catchError in delete and update;
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
