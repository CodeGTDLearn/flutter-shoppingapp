import 'package:get/get.dart';
import 'package:shopingapp/app/modules/orders/controller/orders_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../config/bindings/orders_test_bindings.dart';
import '../../../mocked_datasource/mocked_orders_datasource.dart';

class OrdersControllerTests {
  static void integration() {
    late OrdersController _controller;
    var testConfig = Get.put(OrdersTestBindings());

    setUp(() {
      testConfig.bindingsBuilderMockedRepo(isWidgetTest: true);
      _controller = Get.find<OrdersController>();
    });

    tearDown(Get.reset);

    test('Getting Orders', () {
      expect(_controller.getQtdeOrdersObs(), isZero);
      expect(_controller.getOrdersObs().length, isZero);

      _controller.getOrders().forEach((value) {
        expect(value.id.toString(), isIn(MockedOrdersDatasource().orders()));
        expect(_controller.getQtdeOrdersObs(), isNonZero);
        expect(_controller.getOrdersObs().length, isNonZero);
      });
    });

    test('Clearing Orders', () {
      _controller.getOrders().forEach((value) {
        expect(_controller.getQtdeOrdersObs(), isZero);
        expect(_controller.getOrdersObs().length, isZero);
        expect(value.id.toString(), isIn(MockedOrdersDatasource().orders()));
        expect(_controller.getQtdeOrdersObs(), isNonZero);
        expect(_controller.getOrdersObs().length, isNonZero);
        _controller.clearOrder();
        expect(_controller.getQtdeOrdersObs(), isZero);
        expect(_controller.getOrdersObs().length, isZero);
      });
    });
  }
}
