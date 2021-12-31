import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/properties/app_db_urls.dart';
import '../entity/order.dart';
import 'i_orders_repo.dart';

// ------------- FLUTTER ERROR: FIREBASE RULES DEADLINE/DATE EXPIRE!!! ---------------
// I/flutter ( 8038): The following _TypeError was thrown running a test:
// I/flutter ( 8038): type 'String' is not a subtype of type 'Map<String, dynamic>'
// ------------ SOLUTION: RENEW/REDATE FIREBASE RULES DEADLINE/DATE ------------------
class OrdersRepoHttp extends IOrdersRepo {
  @override
  Future<Order> addOrder(Order order) async {
    // @formatter:off
    return http
        .post(Uri.parse(ORDERS_URL), body: jsonEncode(order.toJson()))
        .then((response) {
      order.id = json.decode(response.body)['name'];
      return order;
    }).catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  Future<List<Order>> getOrders() async {
    // @formatter:off
    return http.get(Uri.parse(ORDERS_URL)).then((jsonResponse) {
      var _orders = <Order>[];

      if (jsonResponse.body == 'null' || jsonResponse.statusCode >= 400) return _orders;

      var ordersDecoded = json.decode(jsonResponse.body) as Map<String, dynamic>;

      ordersDecoded.forEach((id, orderMapped) {
        var orderCreatedFromDataMap = Order.fromJson(orderMapped);
        orderCreatedFromDataMap.id = id;
        _orders.add(orderCreatedFromDataMap);
      });

      return _orders;
    }).catchError((onError) => throw onError);
    // @formatter:on
  }
}