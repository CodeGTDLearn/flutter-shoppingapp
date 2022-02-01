import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/orders/controller/orders_controller.dart';

import '../../../config/titles/orders_test_titles.dart';
import '../../../datasource/mocked_datasource.dart';
import '../../core/bindings/orders_test_bindings.dart';

class OrdersControllerTests {
  void integration() {
    late OrdersController _controller;
    final _titles = Get.find<OrdersTestTitles>();
    final _bindings = Get.put(OrdersTestBindings());


    setUp(() {
      _bindings.bindingsBuilder(isWidgetTest: true, isEmptyDb: false);
      _controller = Get.find<OrdersController>();
    });


    test(_titles.controller_get_orders , () {
      expect(_controller.qtdeOrdersObs.value, isZero);
      expect(_controller.ordersObs.toList().length, isZero);

      _controller.getOrders().forEach((value) {
        expect(value.id.toString(), isIn(MockedDatasource().orders()));
        expect(_controller.qtdeOrdersObs.value, isNonZero);
        expect(_controller.ordersObs.toList().length, isNonZero);
      });
    });

    test(_titles.controller_clear_orders , () {
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