import 'dart:convert';
import 'dart:io';

import 'package:shopingapp/app/pages_modules/orders/entities/order.dart';

import 'mocked_datasource_config.dart';

class OrdersMockedData {
  String _MockedDatasource;

  OrdersMockedData() {
    _MockedDatasource = MOCKED_DATASOURCE_ORDERS;
  }

  List<Order> orders() {
    final file = File(_MockedDatasource);
    final json = jsonDecode(file.readAsStringSync());
    List<Order> result =
        json.map<Order>((json) => Order.fromJson(json)).toList();
    return result;
  }

  Order order() {
    final file = File(_MockedDatasource);
    final json = jsonDecode(file.readAsStringSync());
    List<Order> result =
        json.map<Order>((json) => Order.fromJson(json)).toList();
    return result.elementAt(0);
  }
}
