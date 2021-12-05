import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/orders/controller/orders_controller.dart';

import '../../../datasource/mocked_datasource.dart';
import 'core/orders_test_bindings.dart';

class OrdersControllerTests {
  void integration() {
    late OrdersController _controller;
    var testConfig = Get.put(OrdersTestBindings());

    setUp(() {
      testConfig.bindingsBuilder(isWidgetTest: true, isEmptyDb: false);
      _controller = Get.find<OrdersController>();
    });

    tearDown(Get.reset);

    test('Getting Orders', () {
      expect(_controller.qtdeOrdersObs.value, isZero);
      expect(_controller.ordersObs.toList().length, isZero);

      _controller.getOrders().forEach((value) {
        expect(value.id.toString(), isIn(MockedDatasource().orders()));
        expect(_controller.qtdeOrdersObs.value, isNonZero);
        expect(_controller.ordersObs.toList().length, isNonZero);
      });
    });

    test('Clearing Orders', () {
      _controller.getOrders().forEach((value) {
        expect(_controller.qtdeOrdersObs.value, isZero);
        expect(_controller.ordersObs.toList().length, isZero);
        expect(value.id.toString(), isIn(MockedDatasource().orders()));
        expect(_controller.qtdeOrdersObs.value, isNonZero);
        expect(_controller.ordersObs.toList().length, isNonZero);
        _controller.clearOrder();
        expect(_controller.qtdeOrdersObs.value, isZero);
        expect(_controller.ordersObs.toList().length, isZero);
      });
    });
  }
}