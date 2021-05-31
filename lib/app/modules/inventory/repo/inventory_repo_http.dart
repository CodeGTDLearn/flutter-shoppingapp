import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../../core/properties/app_urls.dart';
import '../entities/product.dart';
import 'i_inventory_repo.dart';

class InventoryRepoHttp implements IInventoryRepo {
  Future<List<Product>> getProducts() {
    return http
        .get(PRODUCTS_URL, headers: {"Accept": "application/json"})
        .then(_decodeResponse)
        .catchError((onError) => throw onError);
  }

  Future<Product> addProduct(Product product) {
    // @formatter:off
    return http
            .post(PRODUCTS_URL, body: jsonEncode(product.toJson()))
            .then((response) {
              var plainText = response.body;
                Map<String, dynamic> json = jsonDecode(plainText);
                product.id = json['name'];
                return product;})
            .catchError((onError) => throw onError);
    // @formatter:on
  }

  Future<int> updateProduct(Product product) {
    final noExtensionInUpdates = PRODUCTS_URL.replaceAll('.json', '/');
    return http
        .patch("$noExtensionInUpdates${product.id}.json",
            body: jsonEncode(product.toJson()))
        .then((response) => response.statusCode);
  }

  Future<int> deleteProduct(String id) {
    // @formatter:off
    final noExtensionInDeletions = PRODUCTS_URL.replaceAll('.json', '/');
    return http
             .delete("$noExtensionInDeletions$id.json")
             .then((response) {
               return response.statusCode;
             });
    // @formatter:on
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
