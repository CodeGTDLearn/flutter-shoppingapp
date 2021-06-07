import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../../core/properties/app_properties.dart';
import '../../../core/properties/app_urls.dart';
import '../../inventory/entities/product.dart';
import 'i_overview_repo.dart';

class OverviewRepoHttp implements IOverviewRepo {
  @override
  Future<List<Product>> getProducts() {
    return http
        .get(Uri.parse(PRODUCTS_URL), headers: HEADER_ACCEPT_JSON)
        .then(_decodeResponse)
        .catchError((onError) => throw onError);
  }

  @override
  Future<int> updateProduct(Product product) {
    return http
        //Product(Object) => Json(.toJson) => PlainText/Firebase(jsonEncode)
        .patch(
          Uri.parse("$PRODUCTS_URL/${product.id}.json"),
          headers: HEADER_ACCEPT_JSON,
          body: jsonEncode(product.toJson()),
        )
        .then((response) => response.statusCode);
  }

  List<Product> _decodeResponse(Response response) {
    var _products = <Product>[];
    //PlainText/Firebase(jsonEncode) ==> Json(Map) ==> List[Product](forEach)
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
//
// final json = jsonDecode(stringResponse.body);
// _products = json.map<Product>((data) => Product.fromJson(data)).toList();
//
//
// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// import '../../../core/properties/app_urls.dart';
// import '../../inventory/entities/product.dart';
// import 'i_overview_repo.dart';
//
// class OverviewRepoHttp implements IOverviewRepo {
//   @override
//   Future<List<Product>> getProducts() {
//     // @formatter:off
//     return http
//         .get(PRODUCTS_URL_HTTP)
//         .then((jsonResponse) {
//       var _products = <Product>[];
//       final MapProductsDecodedFromJsonResponse =
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
//       })
//           :_products = [];
//       return _products;})
//         .catchError((onError){
//       print(">>>>>>>Erro no Firebase: Autenticacao ou "
//           "JsonFormat, etc...>>>>>>: "
//           "$onError");
//       throw onError;
//     });
//     // @formatter:on
//   }
//
//   @override
//   Future<int> updateProduct(Product product, [String id]) {
//     return http
//         .patch("$URL_FIREBASE/$COLLECTION_PRODUCTS/${product.id}$EXTENSION",
//         body: product.toJson())
//         .then((response) => response.statusCode);
//   }
// }
