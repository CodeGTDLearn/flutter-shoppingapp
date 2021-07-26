import 'dart:convert';
import 'dart:io';

import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/overview/components/filter_favorite_enum.dart';

class TestProductsDatasource {
  final MOCKED_DATASOURCE =
      "C:/Users/SERVIDOR/Projects/flutter-shoppingapp/test/test_datasource/mocked_datasource.json";
  late String _MockedDatasource;

  TestProductsDatasource() {
    _MockedDatasource = MOCKED_DATASOURCE;
  }

  List<Product> products() {
    final file = File(_MockedDatasource);
    final json = jsonDecode(file.readAsStringSync())["products"];
    List<Product> result = json.map<Product>((json) => Product.fromJson(json)).toList();
    return result;
  }

  Product product() {
    final file = File(_MockedDatasource);
    final json = jsonDecode(file.readAsStringSync())["products"];
    List<Product> result = json.map<Product>((json) => Product.fromJson(json)).toList();
    return result.elementAt(0);
  }

  List<Product> favoritesProducts() {
    final file = File(_MockedDatasource);
    final json = jsonDecode(file.readAsStringSync())["products"];
    List<Product> list = json.map<Product>((json) => Product.fromJson(json)).toList();
    var listReturn = <Product>[];
    for (var item in list) {
      if (item.isFavorite) listReturn.add(item);
    }
    return listReturn;
  }

  Product productById(String id) {
    final file = File(_MockedDatasource);
    final json = jsonDecode(file.readAsStringSync())["products"];
    List<Product> list = json.map<Product>((json) => Product.fromJson(json)).toList();
    return list.firstWhere((element) => element.id == id);
  }

  List<Product> productsByFilter(EnumFilter filter) {
    return filter == EnumFilter.All
        ? TestProductsDatasource().products()
        : TestProductsDatasource().favoritesProducts();
  }

  List<Product> productsEmpty() {
    return [];
  }
}
