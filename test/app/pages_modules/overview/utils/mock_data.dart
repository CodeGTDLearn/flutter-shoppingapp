import 'dart:convert';
import 'dart:io';

import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';

class MockData {

  List<Product> products() {
    final file = File('assets/mocks_returns/products.json');
    final json = jsonDecode(file.readAsStringSync());
    List<Product> result = json.map<Product>((json) => Product.fromJson(json))
        .toList();
    return result;
  }

  List<Product> favoritesProducts() {
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

  Product productById(String id) {
    final file = File('assets/mocks_returns/products.json');
    final json = jsonDecode(file.readAsStringSync());
    List<Product> list =
    json.map<Product>((json) => Product.fromJson(json)).toList();
    return list.firstWhere((element) => element.id == id);
  }

  List<Product> productsByFilter(EnumFilter filter) {
    return filter == EnumFilter.All
        ? MockData().products()
        : MockData().favoritesProducts();
  }
}


