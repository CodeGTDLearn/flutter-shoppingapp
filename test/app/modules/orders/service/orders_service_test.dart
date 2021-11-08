import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/orders/entity/order.dart';
import 'package:shopingapp/app/modules/orders/service/i_orders_service.dart';

import '../../../../config/bindings/orders_test_bindings.dart';

class OrdersServiceTests {
  void unit() {
    late IOrdersService _service;
    var testConfig = Get.put(OrdersTestBindings());

    setUp(() {
      testConfig.bindingsBuilder(isWidgetTest: true, isEmptyDb: false);
      _service = Get.find<IOrdersService>();
      // _injectService = OrdersInjectMockedService();
      // _cartItems = CartItemDatabuilder.cartItems();
    });

    tearDown(Get.reset);

    test('Getting Orders - ResponseType', () {
      _service.getOrders().then((value) {
        expect(value, isA<List<Order>>());
      });
    });

    test('Getting Orders', () {
      _service.getOrders().then((listReturn) {
        expect(listReturn[0].id, "-MLszdOBBsXxJaPuwZqE");
        expect(listReturn[0].datetime, "2020-10-12T16:37:06.983506");
        expect(listReturn[0].amount, "100.00");
        expect(listReturn[0].cartItems[0].id, "-MJ45uFapLqamB92wOYe");
        expect(listReturn[0].cartItems[0].title, "Red Shirt");
      });
    });

    test('Getting Orders (getLocalDataOrders)', () {
      _service.getOrders().then((_) {
        var list = _service.getLocalDataOrders();
        expect(list[0].id, "-MLszdOBBsXxJaPuwZqE");
        expect(list[0].datetime, "2020-10-12T16:37:06.983506");
        expect(list[0].amount, "100.00");
        expect(list[0].cartItems[0].id, "-MJ45uFapLqamB92wOYe");
        expect(list[0].cartItems[0].title, "Red Shirt");
      });
    });

    test('Getting the Orders Quantity', () {
      _service.getOrders().then((listReturned) {
        var listLocalData = _service.getLocalDataOrders();
        expect(listLocalData.length, _service.ordersQtde());
        expect(listReturned.length, _service.ordersQtde());
      });
    });

    test('Clearing Orders', () {
      _service.getOrders().then((_) {
        var list = _service.getLocalDataOrders();
        expect(list.length, _service.ordersQtde());
        _service.clearOrder();
        expect(_service.ordersQtde(), 0);
      });
    });

    // @formatter:on
  }
}
