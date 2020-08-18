import 'dart:convert';

import 'package:http/http.dart' as connect;

import '../../../core/properties/app_properties.dart';
import '../../managed_products/entities/product.dart';
import 'i_overview_repo.dart';

class OverviewFirebaseRepo implements IOverviewRepo {
  List<Product> _products = [];

  @override
  Future<List<Product>> getProducts() {
    // @formatter:off
    var _AllProducts = <Product>[];

    return connect
        .get(PRODUCTS_URL)
        .then((jsonResponse) {
            final MapDecodedFromJsonResponse =
                json.decode(jsonResponse.body) as Map<String, dynamic>;

            MapDecodedFromJsonResponse
                .forEach((idMap, dataMap) {
                  //print(dataMap['title'].toString());
                  var productObjectCreatedFromDataMap = Product.fromJson(dataMap);

                  _AllProducts.add(productObjectCreatedFromDataMap);
                  //print(">>>>>>> ${productObjectCreatedFromDataMap.title}");
               });
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

    return connect
        .get(PRODUCTS_URL)
        .then((jsonResponse) {
      final MapDecodedFromJsonResponse =
          json.decode(jsonResponse.body) as Map<String, dynamic>;

      MapDecodedFromJsonResponse
          .forEach((idMap, dataMap) {
            //print(dataMap['title'].toString());
            var productObjectCreatedFromDataMap = Product.fromJson(dataMap);

            if (productObjectCreatedFromDataMap.isFavorite) {
              _favoriteProducts.add(productObjectCreatedFromDataMap);
            }
            //print(">>>>>>> ${productCreatedFromDataMap.title}");
          });
      return _favoriteProducts;
    }).catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  void toggleFavoriteStatus(String id) {
    var productFound = getById(id);
    productFound.isFavorite = !productFound.isFavorite;
  }

  @override
  Product getById(String id) {
    return _products
        .firstWhere((productToBeGoten) => productToBeGoten.id == id);
  }
}
