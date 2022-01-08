import 'dart:convert';

import 'package:http/http.dart' as http;

// import 'package:http/http.dart';

import '../../../core/properties/db_urls.dart';
import '../entity/product.dart';
import 'i_inventory_repo.dart';

// ------------- FLUTTER ERROR: FIREBASE RULES DEADLINE/DATE EXPIRE!!! -------------------
// I/flutter ( 8038): The following _TypeError was thrown running a test:
// I/flutter ( 8038): type 'String' is not a subtype of type 'Map<String, dynamic>'
// ------------ SOLUTION: RENEW/REDATE FIREBASE RULES DEADLINE/DATE ----------------------
class InventoryRepoHttp implements IInventoryRepo {
  Future<List<Product>> getProducts() {
    return http
        .get(Uri.parse(PRODUCTS_URL), headers: {"Accept": "application/json"})
        .then(_decodeResponse)
        .catchError((onError) => throw onError);
  }

  Future<Product> addProduct(Product product) {
    // @formatter:off
    return
     http
        .post(
               Uri.parse(PRODUCTS_URL),
               body: jsonEncode(product.toJson())
             )
        .then((response) {
               var plainText = response.body;
               Map<String, dynamic> json = jsonDecode(plainText);
               product.id = json['name'];
               return product;
        })
        .catchError((onError) => throw onError);
    // @formatter:on
  }

  Future<int> updateProduct(Product product) {
    final noExtensionInUrlForUpdates = PRODUCTS_URL.replaceAll('.json', '/');
    var objectMappedInJsonFormat = product.toJson();
    objectMappedInJsonFormat.remove('id');
    return http
        .patch(Uri.parse("$noExtensionInUrlForUpdates${product.id}.json"),
            body: jsonEncode(objectMappedInJsonFormat))
        .then((response) => response.statusCode);
  }

  Future<int> deleteProduct(String id) {
    // @formatter:off
    final noExtensionInDeletions = PRODUCTS_URL.replaceAll('.json', '/');
    return http.delete(Uri.parse("$noExtensionInDeletions$id.json")).then((response) {
      return response.statusCode;
    });
    // @formatter:on
  }

  List<Product> _decodeResponse(http.Response response) {
    var _products = <Product>[];

    var plainText = response.body;
    final json = jsonDecode(plainText);
    json == null
        ? _products = []
        :
        //Rahman
        //    json.map<Product>((resp) => Product.fromJson(resp)).toList();
        // Paulo (anterior)
        json.forEach((key, value) {
            var product = Product.fromJson(value);
            product.id = key;
            _products.add(product);
          });
    return _products;
  }
}