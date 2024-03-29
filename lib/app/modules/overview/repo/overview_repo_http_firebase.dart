import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../../core/properties/db_urls.dart';
import '../../inventory/entity/product.dart';
import 'i_overview_repo.dart';

/*╔═══════════════════════════════════════════════════════════════╗
  ║    'String' is not a subtype of type 'Map<String, dynamic>'   ║
  ╠═══════════════════════════════════════════════════════════════╣
  ║     SOLUTION: RENEW/REDATE FIREBASE RULES DEADLINE/DATE       ║
  ╚═══════════════════════════════════════════════════════════════╝*/
class OverviewRepoHttpFirebase implements IOverviewRepo {
  @override
  Future<List<Product>> getProducts() {
    return http
        .get(Uri.parse(PRODUCTS_URL))
        .then(_decodeResponse)
        .catchError((onError) => throw onError);
  }

  @override
  Future<int> updateProduct(Product product) {
    final noExtensionInUrlForUpdates = PRODUCTS_URL.replaceAll('.json', '/');
    var objectMappedInJsonFormat = product.toJson();
    objectMappedInJsonFormat.remove('id');
    return http
        .patch(Uri.parse("$noExtensionInUrlForUpdates${product.id}.json"),
            body: jsonEncode(objectMappedInJsonFormat))
        .then((response) => response.statusCode);
  }

  List<Product> _decodeResponse(Response response) {
    var _products = <Product>[];
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