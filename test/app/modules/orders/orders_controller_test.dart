import 'package:get/get.dart';
import 'package:shopingapp/app/modules/orders/controller/orders_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../config/orders_test_config.dart';
import '../../../mocked_datasource/orders_mocked_datasource.dart';

class OrdersControllerTests {
  static void integration() {
    late OrdersController _controller;
    var testConfig = Get.put(OrdersTestConfig());

    setUp(() {
      testConfig.bindingsBuilderMockedRepo(isWidgetTest: true);
      _controller = Get.find<OrdersController>();
    });

    tearDown(Get.reset);

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
