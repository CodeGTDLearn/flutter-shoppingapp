import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/properties/app_properties.dart';
import '../../managed_products/entities/product.dart';
import 'i_overview_repo.dart';

class OverviewFirebaseRepo implements IOverviewRepo {
  @override
  Future<List<Product>> getProducts() {
    // @formatter:off
    return http
        .get(PRODUCTS_URL)
        .then((jsonResponse) {
            var _products = <Product>[];
            final MapDecodedFromJsonResponse =
                json.decode(jsonResponse.body) as Map<String, dynamic>;

            MapDecodedFromJsonResponse != null ?
            MapDecodedFromJsonResponse
                .forEach((idMap, dataMap) {
                  var productCreatedFromDataMap = Product.fromJson(dataMap);
                  productCreatedFromDataMap.id = idMap;
                  _products.add(productCreatedFromDataMap);
               })
                :_products = [];
      return _products;
    }).catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  Future<int> updateProduct(Product product) {
    return http
        .patch("$BASE_URL/$COLLECTION_PRODUCTS/${product.id}.json",
            body: product.to_Json())
        .then((statuscode) => statuscode.statusCode);
  }
}

// @override
// Future<Product> getProductById(String id) {
//
//   @formatter:off
//   Product productObjectCreatedFromDataMap;
//
//   return http.get(PRODUCTS_URL)
//       .then((jsonResponse) {
//   final MapDecodedFromJsonResponse =
//   json.decode(jsonResponse.body) as Map<String, dynamic>;
//
//   MapDecodedFromJsonResponse
//       .forEach((idMap, dataMap) {
//   if(idMap == id){
//   productObjectCreatedFromDataMap = Product.fromJson(dataMap);
//   productObjectCreatedFromDataMap.id = idMap;
//   }
//   });
//   return productObjectCreatedFromDataMap;
//   }).catchError((onError) => throw onError);
//   @formatter:on
// }

// @override
// Future<int> updateProduct(Product product) {
//   // @formatter:off
//   // final _index = _dataSavingAllProducts.indexWhere((item) => item.id == id);
//   // var _toggleProduct = _dataSavingAllProducts[_index];
//   // var _rollbackProduct = Product.deepCopy(_toggleProduct);
//
//   // _toggleProduct.isFavorite = !_toggleProduct.isFavorite;
//   // _toggleProduct.isFavorite
//   //     ? _dataSavingFavoritesProducts.add(_toggleProduct)
//   //     : _dataSavingFavoritesProducts.remove(_toggleProduct);
//
//   return http.patch("$BASE_URL/$COLLECTION_PRODUCTS/${product.id}.json",
//       body: product.to_Json())
//       .then((response) {
//     // var favoriteStatus = _toggleProduct.isFavorite;
//     // var badRequest = response.statusCode >= 400;
//     // if (badRequest)favoriteStatus = _rollbackProduct.isFavorite;
//     // if (badRequest)_dataSavingAllProducts[_index] = _rollbackProduct;
//     // if (badRequest && _toggleProduct.isFavorite){
//     //   _dataSavingFavoritesProducts.remove(_toggleProduct);
//     // }
//     // if (badRequest && !_toggleProduct.isFavorite){
//     //     _dataSavingFavoritesProducts.add(_rollbackProduct);
//     // }
//     // _orderDataSavingLists();
//     return response.statusCode;
//   });
//   // @formatter:on
// }

// @override
// Future<List<Product>> getProducts() {
//   // @formatter:off
//   return http
//       .get(PRODUCTS_URL)
//       .then((jsonResponse) {
//     var _gottenProducts = <Product>[];
//
//     final MapDecodedFromJsonResponse =
//     json.decode(jsonResponse.body) as Map<String, dynamic>;
//
//     MapDecodedFromJsonResponse != null ?
//     MapDecodedFromJsonResponse
//         .forEach((idMap, dataMap) {
//       //print(dataMap['title'].toString());
//       var productCreatedFromDataMap = Product.fromJson(dataMap);
//       productCreatedFromDataMap.id = idMap;
//       _gottenProducts.add(productCreatedFromDataMap);
//       //print(">>>>>>> ${productCreatedFromDataMap.title}");
//     })
//         :_gottenProducts = [];
//
//     // clearDataSavingLists();
//
//     // _dataSavingAllProducts = _gottenProducts;
//     // _gottenProducts.forEach((item) {
//     //   if(item.isFavorite) {
//     //   _dataSavingFavoritesProducts.add(item);}
//     // });
//
//     // _orderDataSavingLists();
//
//     return _gottenProducts;
//   }).catchError((onError) => throw onError);
//   // @formatter:on
// }

// List<Product> _dataSavingAllProducts = [];
// List<Product> _dataSavingFavoritesProducts = [];
//
// List<Product> get dataSavingAllProducts => _dataSavingAllProducts;
//
// List<Product> get dataSavingFavoritesProducts => _dataSavingFavoritesProducts;