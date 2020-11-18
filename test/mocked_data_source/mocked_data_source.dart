import 'dart:convert';
import 'dart:io';

import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/orders/entities/order.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';

class MockedDataSource {
  String _pathAssetsJSONDataSourceProducts, _pathAssetsJSONDataSourceOrders;

  MockedDataSource() {
    _pathAssetsJSONDataSourceProducts =
        'assets/mocked_data_sources/products.json';
    _pathAssetsJSONDataSourceOrders = 'assets/mocked_data_sources/orders.json';
  }

  List<Product> products() {
    final file = File(_pathAssetsJSONDataSourceProducts);
    final json = jsonDecode(file.readAsStringSync());
    List<Product> result =
        json.map<Product>((json) => Product.fromJson(json)).toList();
    return result;
  }

  List<Product> favoritesProducts() {
    final file = File(_pathAssetsJSONDataSourceProducts);
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
    final file = File(_pathAssetsJSONDataSourceProducts);
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

  List<Order> orders() {
    final file = File(_pathAssetsJSONDataSourceOrders);
    final json = jsonDecode(file.readAsStringSync());
    List<Order> result =
        json.map<Order>((json) => Order.fromJson(json)).toList();
    return result;
  }

  Order order() {
    final file = File(_pathAssetsJSONDataSourceOrders);
    final json = jsonDecode(file.readAsStringSync());
    List<Order> result =
        json.map<Order>((json) => Order.fromJson(json)).toList();
    return result.elementAt(0);
  }
}
