import 'dart:convert';
import 'dart:io';

import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';

import 'mocked_datasource_config.dart';

class ProductsMockedData {
  String _MockedDatasource;

  ProductsMockedData() {
    _MockedDatasource = MOCKED_DATASOURCE_PRODUCTS;
  }

  List<Product> products() {
    final file = File(_MockedDatasource);
    final json = jsonDecode(file.readAsStringSync());
    List<Product> result =
        json.map<Product>((json) => Product.fromJson(json)).toList();
    return result;
  }

  Product product() {
    final file = File(_MockedDatasource);
    final json = jsonDecode(file.readAsStringSync());
    List<Product> result =
        json.map<Product>((json) => Product.fromJson(json)).toList();
    return result.elementAt(0);
  }

  List<Product> favoritesProducts() {
    final file = File(_MockedDatasource);
    final json = jsonDecode(file.readAsStringSync());
    List<Product> list =
        json.map<Product>((json) => Product.fromJson(json)).toList();
    var listReturn = <Product>[];
    for (var item in list) {
      if (item.isFavorite) listReturn.add(item);
    }
    return listReturn;
  }

  Product productById(String id) {
    final file = File(_MockedDatasource);
    final json = jsonDecode(file.readAsStringSync());
    List<Product> list =
        json.map<Product>((json) => Product.fromJson(json)).toList();
    return list.firstWhere((element) => element.id == id);
  }

  List<Product> productsByFilter(EnumFilter filter) {
    return filter == EnumFilter.All
        ? ProductsMockedData().products()
        : ProductsMockedData().favoritesProducts();
  }

  List<Product> productsEmpty() {
    return [];
  }

  Product productEmpty() {
    return null;
  }
}
