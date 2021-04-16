import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/properties/app_urls.dart';
import '../../inventory/entities/product.dart';
import 'i_overview_repo.dart';

class OverviewRepoHttp implements IOverviewRepo {
  @override
  Future<List<Product>> getProducts() {
    // @formatter:off
    return http
            .get(PRODUCTS_URL)
            .then((jsonResponse) {
                var _products = <Product>[];
                final MapProductsDecodedFromJsonResponse =
                    json.decode(jsonResponse.body) as Map<String, dynamic>;

                // https://medium
                // .com/flutter-community/generate-the-code-to-parse-your-json-in-flutter-c68aa89a81d9
                // https://www.youtube.com/watch?v=NkUtwePWhZo
                // todo: erro authentication to be done
                // MapOrdersDecodedFromJsonResponse != null ||
                //     jsonResponse.statusCode >= 400 ?
                MapProductsDecodedFromJsonResponse != null ?
                MapProductsDecodedFromJsonResponse
                    .forEach((idMap, dataMap) {
                      var productCreatedFromDataMap = Product.fromJson(dataMap);
                      productCreatedFromDataMap.id = idMap;
                      _products.add(productCreatedFromDataMap);
                    })
                    :_products = [];
                return _products;})
            .catchError((onError){
              print(">>>> Erro no Firebase: Autenticacao ou JsonFormat, etc...>>>: "
                  "$onError");
              throw onError;
            });
    // @formatter:on
  }

  @override
  Future<int> updateProduct(Product product, [String id]) {
    return http
        .patch("$BASE_URL/$COLLECTION_PRODUCTS/${product.id}$EXTENSION",
            body: product.toJson())
        .then((response) => response.statusCode);
  }
}
