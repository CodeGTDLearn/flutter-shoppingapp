import 'dart:convert';
import 'dart:io';

import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';

class MockedDataSource {
  String _pathJSONDataSource;

  MockedDataSource() {
    _pathJSONDataSource = 'assets/mocked_data_sources/products.json';
  }

  List<Product> products() {
    final file = File(_pathJSONDataSource);
    final json = jsonDecode(file.readAsStringSync());
    List<Product> result =
        json.map<Product>((json) => Product.fromJson(json)).toList();
    return result;
  }

  List<Product> favoritesProducts() {
    final file = File(_pathJSONDataSource);
    final json = jsonDecode(file.readAsStringSync());
    List<Product> list =
        json.map<Product>((json) => Product.fromJson(json)).toList();
    List<Product> listReturn = [];
    list.forEach((item) {
      if (item.isFavorite) listReturn.add(item);
    });
    return listReturn;
  }

  Product productById(String id) {
    final file = File(_pathJSONDataSource);
    final json = jsonDecode(file.readAsStringSync());
    List<Product> list =
        json.map<Product>((json) => Product.fromJson(json)).toList();
    return list.firstWhere((element) => element.id == id);
  }

  List<Product> productsByFilter(EnumFilter filter) {
    return filter == EnumFilter.All
        ? MockedDataSource().products()
        : MockedDataSource().favoritesProducts();
  }

  List<Product> productsEmpty() {
    return [];
  }
}
