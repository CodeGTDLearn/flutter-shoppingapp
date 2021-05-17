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
        .patch("$PRODUCTS_URL/${product.id}.json",
            //Product(Object) => Json(.toJson) => PlainText/Firebase(jsonEncode)
            body: jsonEncode(product.toJson()))
        .then((response) => response.statusCode);
  }

  Future<int> deleteProduct(String id) {
    return http
        .delete("$PRODUCTS_URL/$id.json")
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
