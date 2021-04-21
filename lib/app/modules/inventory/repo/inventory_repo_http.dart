import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../../core/properties/app_urls.dart';
import '../entities/product.dart';
import 'i_inventory_repo.dart';

class InventoryRepoHttp implements IInventoryRepo {
  Future<List<Product>> getProducts() {
    return http
        .get(PRODUCTS_URL_HTTP, headers: {"Accept": "application/json"})
        .then(_decodeResponse)
        .catchError((onError) => throw onError);
  }

  Future<Product> addProduct(Product product) {
    // @formatter:off
    return http
            .post(PRODUCTS_URL_HTTP, body: jsonEncode(product.toJson()))
            .then((response) {
              //PlainText/Firebase(jsonEncode) ==> Json(Map) ==> Product
              var plainText = response.body;
                Map<String, dynamic> json = jsonDecode(plainText);
                product.id = json['name'];
                return product;})
            .catchError((onError) => throw onError);
    // @formatter:on
  }

  Future<int> updateProduct(Product product) {
    return http
        .patch("$URL_FIREBASE/$COLLECTION_PRODUCTS/${product.id}$EXTENSION",
            //Product(Object) => Json(.toJson) => PlainText/Firebase(jsonEncode)
            body: jsonEncode(product.toJson()))
        .then((response) => response.statusCode);
  }

  Future<int> deleteProduct(String id) {
    return http
        .delete("$URL_FIREBASE/$COLLECTION_PRODUCTS/$id$EXTENSION")
        .then((response) => response.statusCode);
  }

  List<Product> _decodeResponse(Response response) {
    var _products = <Product>[];

    //PlainText/Firebase(jsonEncode) ==> Json(Map) ==> List[Product](List - forEach)
    var plainText = response.body;
    final json = jsonDecode(plainText);
    json == null
        ? _products = []
        : json.forEach((key, value) {
            var product = Product.fromJson(value);
            product.id = key;
            _products.add(product);
          });
    return _products;
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
