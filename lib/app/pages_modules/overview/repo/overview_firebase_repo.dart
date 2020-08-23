import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/properties/app_properties.dart';
import '../../managed_products/entities/product.dart';
import 'i_overview_repo.dart';

class OverviewFirebaseRepo implements IOverviewRepo {
  @override
  Future<List<Product>> getProducts() {
    // @formatter:off
    var _AllProducts = <Product>[];

    return http
        .get(PRODUCTS_URL)
        .then((jsonResponse) {
            final MapDecodedFromJsonResponse =
                json.decode(jsonResponse.body) as Map<String, dynamic>;

            MapDecodedFromJsonResponse != null ?
            MapDecodedFromJsonResponse
                .forEach((idMap, dataMap) {
                  //print(dataMap['title'].toString());
                  var productObjectCreatedFromDataMap = Product.fromJson(dataMap);

                  _AllProducts.add(productObjectCreatedFromDataMap);
                  //print(">>>>>>> ${productObjectCreatedFromDataMap.title}");
               })
                :_AllProducts = [];
      return _AllProducts;
    }).catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  int getProductsQtde() {
    int productsQtde;
    getProducts().then((value) {
      productsQtde = value.length;
    });
    return productsQtde;
  }

  @override
  int getFavoritesQtde() {
    getFavorites().then((value) {
      return value.length == null ? 0 : value.length;
    });
  }

  @override
  Future<List<Product>> getFavorites() {
    // @formatter:off
    var _favoriteProducts = <Product>[];

    return http
        .get(PRODUCTS_URL)
        .then((jsonResponse) {
      final MapDecodedFromJsonResponse =
          json.decode(jsonResponse.body) as Map<String, dynamic>;

      MapDecodedFromJsonResponse
          .forEach((idMap, dataMap) {
            var productObjectCreatedFromDataMap = Product.fromJson(dataMap);

            if (productObjectCreatedFromDataMap.isFavorite) {
              _favoriteProducts.add(productObjectCreatedFromDataMap);
            }
          });
      return _favoriteProducts;
    }).catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  Future<bool> toggleFavoriteStatus(String id) {
    getById(id).then((productFound) {
      http.patch("$BASE_URL/$COLLECTION_PRODUCTS/${productFound.id}.json",
          body: productFound.to_Json());
    });

//    return http
//        .patch("$BASE_URL/$COLLECTION_PRODUCTS/${productFound.id}.json",
//            body: productFound.to_Json())
//        .then((response) {})
//        .catchError((onError) => throw onError);

//    productFound.isFavorite = !productFound.isFavorite;
//    return productFound.isFavorite;
  }

  @override
  Future<Product> getById(String id) {
    // @formatter:off
    Product productObjectCreatedFromDataMap;

    return http.get(PRODUCTS_URL)
        .then((jsonResponse) {
      final MapDecodedFromJsonResponse =
      json.decode(jsonResponse.body) as Map<String, dynamic>;

      MapDecodedFromJsonResponse
          .forEach((idMap, dataMap) {
        if(idMap == id){
          productObjectCreatedFromDataMap = Product.fromJson(dataMap);
          productObjectCreatedFromDataMap.id = idMap;
        }
      });
      return productObjectCreatedFromDataMap;
    }).catchError((onError) => throw onError);
    // @formatter:on

//    return _products
//        .firstWhere((productToBeGoten) => productToBeGoten.id == id);
  }
}
