import 'dart:convert';
import 'dart:io';

import 'package:shopingapp/app/pages_modules/orders/entities/order.dart';

class OrdersMockedData {
  String _pathAssetsJsonMockedData;

  OrdersMockedData() {
    _pathAssetsJsonMockedData = 'assets/mocked_data_sources/orders.json';
  }

  List<Order> orders() {
    final file = File(_pathAssetsJsonMockedData);
    final json = jsonDecode(file.readAsStringSync());
    List<Order> result =
        json.map<Order>((json) => Order.fromJson(json)).toList();
    return result;
  }

  Order order() {
    final file = File(_pathAssetsJsonMockedData);
    final json = jsonDecode(file.readAsStringSync());
    List<Order> result =
        json.map<Order>((json) => Order.fromJson(json)).toList();
    return result.elementAt(0);
  }
}
