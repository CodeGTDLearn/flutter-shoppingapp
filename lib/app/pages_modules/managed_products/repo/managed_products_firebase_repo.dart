import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/properties/app_urls.dart';
import '../entities/product.dart';
import 'i_managed_products_repo.dart';

class ManagedProductsFirebaseRepo implements IManagedProductsRepo {
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
            var productObjectCreatedFromDataMap = Product.fromJson(dataMap);
            productObjectCreatedFromDataMap.id = idMap;
            _gottenProducts.add(productObjectCreatedFromDataMap);
          })
            :_gottenProducts = [];
        return _gottenProducts;
    }).catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  Future<Product> saveProduct(Product product) {
    // @formatter:off
    return http
        .post(PRODUCTS_URL, body: product.to_Json())
        .then((response) {
            product.id = json.decode(response.body)['name'];
            return product;
        })
        .catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  Future<int> updateProduct(Product product) {
    return http
        .patch("$BASE_URL/$COLLECTION_PRODUCTS/${product.id}$EXTENSION",
            body: product.to_Json())
        .then((response) => response.statusCode);
    //there is no catchError in delete
  }

  @override
  Future<int> deleteProduct(String id) {
    return http
        .delete("$BASE_URL/$COLLECTION_PRODUCTS/$id$EXTENSION")
        .then((response) => response.statusCode);
    //there is no catchError in delete and update;
  }
}