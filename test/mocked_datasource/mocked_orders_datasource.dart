import 'dart:convert';
import 'dart:io';

import 'package:shopingapp/app/modules/orders/entities/order.dart';

import '../config/tests_config.dart';

class MockedOrdersDatasource {
  final _datasource = MOCKED_DATASOURCE;
  late String _mockedDatasource;

  MockedOrdersDatasource() {
    _mockedDatasource = _datasource;
  }

  List<Order> orders() {
    final file = File(_mockedDatasource);
    final json = jsonDecode(file.readAsStringSync())["orders"];
    List<Order> result = json.map<Order>((json) => Order.fromJson(json)).toList();
    return result;
  }

  Order order() {
    final file = File(_mockedDatasource);
    final json = jsonDecode(file.readAsStringSync())["orders"];
    List<Order> result = json.map<Order>((json) => Order.fromJson(json)).toList();
    return result.elementAt(0);
  }

  List<Order> ordersEmpty() {
    return [];
  }
}
