import 'dart:convert';
import 'dart:io';

import 'package:shopingapp/app/modules/inventory/entity/product.dart';
import 'package:shopingapp/app/modules/orders/entity/order.dart';
import 'package:shopingapp/app/modules/overview/core/components/overview_appbar/filter_options_enum.dart';
import 'package:shopingapp/app/modules/warehouse/warehouse.dart';

import '../app_tests_properties.dart';

class MockedDatasource {
  final _MockedDataMassPathFile = MOCKED_DATA_MASS_PATH_FILE;

  // PRODUCTS DATASOURCE
  List<Product> products() {
    List<Product> productList = _generateProductListFromFile();
    return productList;
  }

  Product product() {
    List<Product> productList = _generateProductListFromFile();
    return productList.elementAt(0);
  }

  List<Product> favoritesProducts() {
    List<Product> productList = _generateProductListFromFile();
    var listReturn = <Product>[];
    for (var item in productList) {
      if (item.isFavorite) listReturn.add(item);
    }
    return listReturn;
  }

  Product productById(String id) {
    List<Product> productList = _generateProductListFromFile();
    return productList.firstWhere((element) => element.id == id);
  }

  List<Product> _generateProductListFromFile() {
    final jsonContentFile = File(_MockedDataMassPathFile);
    final List<dynamic> genericList = jsonDecode(jsonContentFile.readAsStringSync())["products"];
    final List<Product> productList = genericList.map((item) => Product.fromJson(item)).toList();
    return productList;
  }

  List<Product> productsByFilter(FilterOptionsEnum filter) {
    return filter == FilterOptionsEnum.All
        ? MockedDatasource().products()
        : MockedDatasource().favoritesProducts();
  }

  List<Product> productsEmpty() {
    return [];
  }

  // ORDERS DATASOURCE
  List<Order> orders() {
    List<Order> orderList = _generateOrderListFromFile();
    return orderList;
  }

  List<Order> _generateOrderListFromFile() {
    final jsonContentFile = File(_MockedDataMassPathFile);
    final List<dynamic> genericList = jsonDecode(jsonContentFile.readAsStringSync())["orders"];
    final List<Order> orderList = genericList.map((item) => Order.fromJson(item)).toList();
    return orderList;
  }

  Order order() {
    List<Order> orderList = _generateOrderListFromFile();
    return orderList.elementAt(0);
  }

  List<Order> ordersEmpty() {
    return [];
  }

  // DEPOTS DATASOURCE
  List<Warehouse> depots() {
    List<Warehouse> warehouseList = _generateWarehouseListFromFile();
    return warehouseList;
  }

  List<Warehouse> _generateWarehouseListFromFile() {
    final jsonContentFile = File(_MockedDataMassPathFile);
    final List<dynamic> genericList = jsonDecode(jsonContentFile.readAsStringSync())["depots"];
    final List<Warehouse> warehouseList = genericList.map((item) => Warehouse.fromJson(item)).toList();
    return warehouseList;
  }
}