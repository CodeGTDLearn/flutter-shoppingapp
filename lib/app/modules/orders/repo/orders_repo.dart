import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/properties/app_urls.dart';
import '../entities/order.dart';
import 'i_orders_repo.dart';

class OrdersRepo extends IOrdersRepo {

  @override
  Future<Order> addOrder(Order order) async {
    // @formatter:off
    return http
        .post(ORDERS_URL_HTTP, body: order.to_Json())
        .then((jsonReturnedOrder) {
           order.id = json.decode(jsonReturnedOrder.body)['name'];
           return order;
        })
        .catchError((onError)=> throw onError);
    // @formatter:on
  }

  @override
  Future<List<Order>> getOrders() async {
    // @formatter:off
    return http
        .get(ORDERS_URL_HTTP)
        .then((jsonResponse) {
        var _orders = <Order>[];
        
        final MapOrdersDecodedFromJsonResponse =
        json.decode(jsonResponse.body) as Map<String, dynamic>;

        MapOrdersDecodedFromJsonResponse != null ||
            jsonResponse.statusCode >= 400 ?
        MapOrdersDecodedFromJsonResponse
          .forEach((idMap, dataMap) {
            var orderCreatedFromDataMap = Order.fromJson(dataMap);

            orderCreatedFromDataMap.id = idMap;

            _orders.add(orderCreatedFromDataMap);
          })
          :_orders = [];
      return _orders;
    }).catchError((onError) => throw onError);
    // @formatter:on
  }
}
