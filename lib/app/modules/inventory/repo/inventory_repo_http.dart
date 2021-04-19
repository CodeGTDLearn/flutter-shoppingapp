import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/properties/app_urls.dart';
import '../entities/product.dart';
import 'i_inventory_repo.dart';

class InventoryRepoHttp implements IInventoryRepo {
  Future<List<Product>> getProducts() {
    // @formatter:off
    return http
        .get(PRODUCTS_URL_HTTP, headers: {"Accept": "application/json"})
        .then((stringResponse) {
            var _products = <Product>[];
            final json = jsonDecode(stringResponse.body);
            json == null ? _products = [] :
            _products = json.map<Product>((data) => Product.fromJson(data)).toList();
            return _products;})
        .catchError((onError){
            print(">>> Erro: $onError");
            throw onError;});
    // @formatter:on
  }

  Future<Product> addProduct(Product product) {
    // @formatter:off
    return http
            .post(PRODUCTS_URL_HTTP, body: product.toJson())
            .then((response) {
                product.id = json.decode(response.body)['name'];
                return product;})
            .catchError((onError) => throw onError);
    // @formatter:on
  }

  Future<int> updateProduct(Product product) {
    return http
        .patch("$URL_FIREBASE/$COLLECTION_PRODUCTS/${product.id}$EXTENSION",
            body: product.toJson())
        .then((response) => response.statusCode);
    //there is no catchError in delete
  }

  Future<int> deleteProduct(String id) {
    return http
        .delete("$URL_FIREBASE/$COLLECTION_PRODUCTS/$id$EXTENSION")
        .then((response) => response.statusCode);
    //there is no catchError in delete and update;
  }
}

// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// import '../../../core/properties/app_urls.dart';
// import '../entities/product.dart';
// import 'i_inventory_repo.dart';
//
// class InventoryRepo implements IInventoryRepo {
//
//   Future<List<Product>> getProducts() {
//     // @formatter:off
//     return http
//         .get(PRODUCTS_URL_HTTP)
//         .then((jsonResponse) {
//       var _products = <Product>[];
//       var MapProductsDecodedFromJsonResponse =
//       json.decode(jsonResponse.body) as Map<String, dynamic>;
//
//       // todo: erro authentication to be done
//       // MapOrdersDecodedFromJsonResponse != null ||
//       //     jsonResponse.statusCode >= 400 ?
//       MapProductsDecodedFromJsonResponse != null ?
//       MapProductsDecodedFromJsonResponse
//           .forEach((idMap, dataMap) {
//         var productCreatedFromDataMap = Product.fromJson(dataMap);
//         productCreatedFromDataMap.id = idMap;
//         _products.add(productCreatedFromDataMap);
//       }):_products = [];
//       return _products;})
//         .catchError((onError) => throw onError);
//     // @formatter:on
//   }
//
//
//   Future<Product> addProduct(Product product) {
//     // @formatter:off
//     return http
//         .post(PRODUCTS_URL_HTTP, body: product.toJson())
//         .then((response) {
//       product.id = json.decode(response.body)['name'];
//       return product;})
//         .catchError((onError) => throw onError);
//     // @formatter:on
//   }
//
//
//   Future<int> updateProduct(Product product) {
//     return http
//         .patch("$URL_FIREBASE/$COLLECTION_PRODUCTS/${product.id}$EXTENSION",
//         body: product.toJson())
//         .then((response) => response.statusCode);
//     //there is no catchError in delete
//   }
//
//
//   Future<int> deleteProduct(String id) {
//     return http
//         .delete("$URL_FIREBASE/$COLLECTION_PRODUCTS/$id$EXTENSION")
//         .then((response) => response.statusCode);
//     //there is no catchError in delete and update;
//   }
// }
