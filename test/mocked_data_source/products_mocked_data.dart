import 'dart:convert';
import 'dart:io';

import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';

class ProductsMockedData {
  String _pathAssetsJsonMockedData;

  ProductsMockedData() {
    _pathAssetsJsonMockedData = 'assets/mocked_data_sources/products.json';
  }

  List<Product> products() {
    final file = File(_pathAssetsJsonMockedData);
    final json = jsonDecode(file.readAsStringSync());
    List<Product> result =
        json.map<Product>((json) => Product.fromJson(json)).toList();
    return result;
  }

  List<Product> favoritesProducts() {
    final file = File(_pathAssetsJsonMockedData);
    final json = jsonDecode(file.readAsStringSync());
    List<Product> list =
        json.map<Product>((json) => Product.fromJson(json)).toList();
    var listReturn = <Product>[];
    for (var item in list) {
      if (item.isFavorite) listReturn.add(item);
    }
    // list.forEach((item) {
    //   if (item.isFavorite) listReturn.add(item);
    // });
    return listReturn;
  }

  Product productById(String id) {
    final file = File(_pathAssetsJsonMockedData);
    final json = jsonDecode(file.readAsStringSync());
    List<Product> list =
        json.map<Product>((json) => Product.fromJson(json)).toList();
    return list.firstWhere((element) => element.id == id);
  }

  Product product() {
    final file = File(_pathAssetsJsonMockedData);
    final json = jsonDecode(file.readAsStringSync());
    List<Product> result =
        json.map<Product>((json) => Product.fromJson(json)).toList();
    return result.elementAt(0);
  }

  List<Product> productsByFilter(EnumFilter filter) {
    return filter == EnumFilter.All
        ? ProductsMockedData().products()
        : ProductsMockedData().favoritesProducts();
  }

  List<Product> productsEmpty() {
    return [];
  }
}
