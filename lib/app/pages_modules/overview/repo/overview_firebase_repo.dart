import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/properties/app_properties.dart';
import '../../managed_products/entities/product.dart';
import 'i_overview_repo.dart';

class OverviewFirebaseRepo implements IOverviewRepo {
  List<Product> _dataSavingList_OverviewProducts = [];
  List<Product> _dataSavingList_OverviewFavoritesProducts = [];

  List<Product> get dataSavingListOverviewProducts =>
      _dataSavingList_OverviewProducts;

  List<Product> get dataSavingListOverviewFavoritesProducts =>
      _dataSavingList_OverviewFavoritesProducts;

  @override
  Future<List<Product>> getOverviewProducts() {
    // @formatter:off
    var _gottenProducts = <Product>[];
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

                  _gottenProducts.add(productObjectCreatedFromDataMap);
                  //print(">>>>>>> ${productObjectCreatedFromDataMap.title}");
               })
                :_gottenProducts = [];
            _dataSavingList_OverviewFavoritesProducts.clear();
            _dataSavingList_OverviewProducts.clear();

            _dataSavingList_OverviewProducts = _gottenProducts;

            _gottenProducts.forEach((item) {
              if(item.isFavorite) {
              _dataSavingList_OverviewFavoritesProducts.add(item);}
            });

      return _gottenProducts;
    }).catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  Future<bool> toggleOverviewProductFavoriteStatus(String id) {

    // @formatter:off
    final _indexAll =
          _dataSavingList_OverviewProducts
              .indexWhere((item) => item.id == id);

    final _indexFav =
          _dataSavingList_OverviewFavoritesProducts
              .indexWhere((item) => item.id == id);

    getOverviewProductById(id)
        .then((foundProduct) {
          foundProduct.isFavorite = !foundProduct.isFavorite;

          http
             .patch("$BASE_URL/$COLLECTION_PRODUCTS/${foundProduct.id}.json",
             body: foundProduct.to_Json())
                .then((response) {
                  if (response.statusCode >= 200 && response.statusCode >= 299) {
                    _dataSavingList_OverviewProducts[_indexAll] = foundProduct;
                  }
                  if ((response.statusCode >= 200 && response.statusCode >= 299)
                      && foundProduct.isFavorite) {
                    _dataSavingList_OverviewFavoritesProducts
                          .add(foundProduct);
                  }else{
                    _dataSavingList_OverviewFavoritesProducts
                          .removeAt(_indexFav);
                  }
                });
        });
    // @formatter:on
  }

  @override
  Future<Product> getOverviewProductById(String id) {
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
//  @override
//  int getOverviewProductsQtde() {
//    int productsQtde;
//    getOverviewProducts().then((value) {
//      productsQtde = value.length;
//    });
//    return productsQtde;
//  }
//
//  @override
//  int getOverviewFavoritesQtde() {
//    int favoritesProductsQtde;
//    getOverviewFavoriteProducts().then((value) {
//      favoritesProductsQtde = value.length == null ? 0 : value.length;
//    });
//    return favoritesProductsQtde;
//  }

//    return http
//        .patch("$BASE_URL/$COLLECTION_PRODUCTS/${productFound.id}.json",
//            body: productFound.to_Json())
//        .then((response) {})
//        .catchError((onError) => throw onError);

//    productFound.isFavorite = !productFound.isFavorite;
//    return productFound.isFavorite;
//  @override
//  Future<List<Product>> getOverviewFavoriteProducts() {
//    // @formatter:off
//    var _favoriteProducts = <Product>[];
//
//    return http
//        .get(PRODUCTS_URL)
//        .then((jsonResponse) {
//      final MapDecodedFromJsonResponse =
//          json.decode(jsonResponse.body) as Map<String, dynamic>;
//
//      MapDecodedFromJsonResponse
//          .forEach((idMap, dataMap) {
//            var productObjectCreatedFromDataMap = Product.fromJson(dataMap);
//
//            if (productObjectCreatedFromDataMap.isFavorite) {
//              _favoriteProducts.add(productObjectCreatedFromDataMap);
//            }
//          });
//      return _favoriteProducts;
//    }).catchError((onError) => throw onError);
//    // @formatter:on
//  }
