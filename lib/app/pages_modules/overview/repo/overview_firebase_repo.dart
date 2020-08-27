import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/properties/app_properties.dart';
import '../../managed_products/entities/product.dart';
import 'i_overview_repo.dart';

class OverviewFirebaseRepo implements IOverviewRepo {
  List<Product> _dataSavingListProducts = [];
  List<Product> _dataSavingListFavoritesProducts = [];

  List<Product> get dataSavingListOverviewProducts => _dataSavingListProducts;

  List<Product> get dataSavingListOverviewFavoritesProducts =>
      _dataSavingListFavoritesProducts;

  @override
  Future<List<Product>> getOverviewProducts() {
    // @formatter:off
    return http
        .get(PRODUCTS_URL)
        .then((jsonResponse) {
            var _gottenProducts = <Product>[];
            final MapDecodedFromJsonResponse =
                json.decode(jsonResponse.body) as Map<String, dynamic>;

            MapDecodedFromJsonResponse != null ?
            MapDecodedFromJsonResponse
                .forEach((idMap, dataMap) {
                  //print(dataMap['title'].toString());
                  var productObjectCreatedFromDataMap = Product.fromJson(dataMap);
                  productObjectCreatedFromDataMap.id = idMap;
                  _gottenProducts.add(productObjectCreatedFromDataMap);
                  //print(">>>>>>> ${productObjectCreatedFromDataMap.title}");
               })
                :_gottenProducts = [];

            _dataSavingListFavoritesProducts = [];
            _dataSavingListProducts = [];

            _dataSavingListProducts = _gottenProducts;
            _gottenProducts.forEach((item) {
              if(item.isFavorite) {
              _dataSavingListFavoritesProducts.add(item);}
            });

            _orderDataSavingLists();
//            _dataSavingListProducts.toList().reversed;
//            _dataSavingListFavoritesProducts.toList().reversed;

      return _gottenProducts;
    }).catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  Future<bool> toggleFavoriteStatus(String id) {
    // @formatter:off
    final _indexAll = _dataSavingListProducts.indexWhere((item) => item.id == id);
    var _rollbackProduct = _dataSavingListProducts[_indexAll];
    var _productToToggle = Product.deepCopy(_rollbackProduct);

    _productToToggle.isFavorite = !_productToToggle.isFavorite;

    _dataSavingListProducts[_indexAll] = _productToToggle;
    
    _productToToggle.isFavorite
        ? _dataSavingListFavoritesProducts.add(_productToToggle)
        : _dataSavingListFavoritesProducts.removeAt(_indexAll);

    return http.patch("$BASE_URL/$COLLECTION_PRODUCTS/$id.json",
         body: _productToToggle.to_Json())
            .then((resp) {
              var status = resp.statusCode >= 200 && resp.statusCode <= 299;
              var futureBoolReturn;
              if (status) futureBoolReturn = _productToToggle.isFavorite;
              if (_productToToggle.isFavorite && !status){
                  _dataSavingListFavoritesProducts.remove(_productToToggle);
                  _dataSavingListProducts[_indexAll] = _rollbackProduct;
                  futureBoolReturn = _rollbackProduct.isFavorite;
              }
              if (!_productToToggle.isFavorite && !status){
                  _dataSavingListProducts[_indexAll] = _rollbackProduct;
                  futureBoolReturn = _rollbackProduct.isFavorite;
              }
              _orderDataSavingLists();
              return futureBoolReturn;
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

  void _orderDataSavingLists() {
    _dataSavingListProducts.toList().reversed;
    _dataSavingListFavoritesProducts.toList().reversed;
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
