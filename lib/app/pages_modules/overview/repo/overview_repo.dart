import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../core/properties/app_urls.dart';

import '../../managed_products/entities/product.dart';
import 'i_overview_repo.dart';

class OverviewRepo implements IOverviewRepo {

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
        .patch("$BASE_URL/$COLLECTION_PRODUCTS/${product.id}$EXTENSION",
            body: product.to_Json())
        .then((response) => response.statusCode);
  }
}
