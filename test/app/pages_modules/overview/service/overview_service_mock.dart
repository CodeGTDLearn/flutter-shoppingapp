import 'dart:convert';
import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';

class PredefinedMockService extends Mock implements IOverviewService {

  /* **************************************************
*   A) PREDEFINED MOCKS:
*     Predefined Mocks does NOT ALLOW
*     the "WHEN" clause (because they has predefined responses)
*     Although, they extends Mockito (Mock)
*
*     Mocks com Responses Predefinidas(PredefinedMockRepo)
*     NAO PERMITEM a clausula "WHEN" (pois possuem retorno predefinido)
*     Embora, eles extendam o Mockito("Mock)
*
*   B) Custom MOCKS:
*     Custom Mocks (CustomMockRepo)
*     are "Plain Mocks" (because they has NOT predefined responses);
*     thus, they ALLOW the "Custom" clause
*
*     Custom Mocks sao Mocks Zerados(sem qqer retorno predefinido)
*     portanto, PERMITEM a clausula "Custom"
*****************************************************/
  @override
  List<Product> get dataSavingAllProducts {
    return getProductsFromJsonFile();
  }

  @override
  List<Product> get dataSavingFavoritesProducts {
    return getFavoritesFromJsonFile();
  }

  @override
  int getFavoritesQtde() {
    return getFavoritesFromJsonFile().length;
  }

  @override
  Product getProductById(String id) {
    final file = File('assets/mocks_returns/products.json');
    final json = jsonDecode(file.readAsStringSync());
    List<Product> list =
    json.map<Product>((json) => Product.fromJson(json)).toList();
    return list.firstWhere((element) => element.id == id);
  }

  @override
  Future<List<Product>> getProducts() async {
    return Future.value(getProductsFromJsonFile());
  }

  @override
  List<Product> getProductsByFilter(EnumFilter filter) {
    return filter == EnumFilter.All
        ? getProductsFromJsonFile()
        : getFavoritesFromJsonFile();
  }

  @override
  int getProductsQtde() {
    var listProducts = getProductsFromJsonFile();
    return listProducts.length;
  }

  @override
  Future<bool> toggleFavoriteStatus(String id) {
    List<Product> result = getProductsFromJsonFile();
    result.forEach((element) {
      if (element.id == id) element.isFavorite = !element.isFavorite;
    });
    return Future.value(true);
  }

  List<Product> getProductsFromJsonFile() {
    final file = File('assets/mocks_returns/products.json');
    final json = jsonDecode(file.readAsStringSync());
    List<Product> result = json.map<Product>((json) => Product.fromJson(json)).toList();
    return result;
  }

  List<Product> getFavoritesFromJsonFile() {
    final file = File('assets/mocks_returns/products.json');
    final json = jsonDecode(file.readAsStringSync());
    List<Product> list =
        json.map<Product>((json) => Product.fromJson(json)).toList();
    List<Product> listReturn = [];
    list.forEach((item) {
      if (item.isFavorite) listReturn.add(item);
    });
    return listReturn;
  }
}

class CustomMockService extends Mock implements IOverviewService {}
