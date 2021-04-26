import 'package:get/get.dart';
import 'package:shopingapp/app/modules/orders/controller/orders_controller.dart';
import 'package:test/test.dart';

import '../../../test_utils/mocked_datasource/orders_mocked_datasource.dart';
import 'orders_test_config.dart';

class OrdersControllerTest {
  static void integration() {
    OrdersController _controller;

    setUp(() {
      OrdersTestConfig().bindingsBuilder();
      _controller = Get.find<OrdersController>();
    });

    test('Getting Orders', () {
      expect(_controller.getQtdeOrdersObs(), isZero);
      expect(_controller.getOrdersObs().length, isZero);

      _controller.getOrders().forEach((value) {
        expect(value.id.toString(), isIn(OrdersMockedDatasource().orders()));
        expect(_controller.getQtdeOrdersObs(), isNonZero);
        expect(_controller.getOrdersObs().length, isNonZero);
      });
    });

    test('Clearing Orders', () {
      _controller.getOrders().forEach((value) {
        expect(_controller.getQtdeOrdersObs(), isZero);
        expect(_controller.getOrdersObs().length, isZero);
        expect(value.id.toString(), isIn(OrdersMockedDatasource().orders()));
        expect(_controller.getQtdeOrdersObs(), isNonZero);
        expect(_controller.getOrdersObs().length, isNonZero);
        _controller.clearOrder();
        expect(_controller.getQtdeOrdersObs(), isZero);
        expect(_controller.getOrdersObs().length, isZero);
      });
    });
  }
}
