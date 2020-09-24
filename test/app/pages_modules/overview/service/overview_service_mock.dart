import 'dart:convert';
import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';

class PredefinedMockService extends Mock implements IOverviewService {

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
    return getProductsFromJsonFile().length;
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
    var result = json.map<Product>((json) => Product.fromJson(json)).toList();
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
