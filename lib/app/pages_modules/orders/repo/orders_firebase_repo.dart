import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/properties/app_properties.dart';
import '../entities/order.dart';
import 'i_orders_repo.dart';

class OrdersFirebaseRepo extends IOrdersRepo {
  final List<Order> _orders = [];

  @override
  Future<Order> saveOrder(Order order) async {
    // @formatter:off
    return http
        .post(ORDERS_URL, body: order.to_Json())
        .then((response) {
           order.id = json.decode(response.body)['name'];
           return order;
        })
        .catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  Future<List<Order>> getOrders() async {
    // @formatter:off
    return http
        .get(ORDERS_URL)
        .then((jsonResponse) {
        var _gottenOrders = <Order>[];
        final MapDecodedFromJsonResponse =
        json.decode(jsonResponse.body) as Map<String, dynamic>;
        MapDecodedFromJsonResponse != null ?
        MapDecodedFromJsonResponse
          .forEach((idMap, dataMap) {
            var orderObjectCreatedFromDataMap = Order.fromJson(dataMap);
            orderObjectCreatedFromDataMap.id = idMap;
            _gottenOrders.add(orderObjectCreatedFromDataMap);
          })
          :_gottenOrders = [];
      return _gottenOrders;
    }).catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  void clearOrders() {
    _orders.clear();
  }
}
