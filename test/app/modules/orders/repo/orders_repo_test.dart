import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/orders/entity/order.dart';
import 'package:shopingapp/app/modules/orders/repo/i_orders_repo.dart';

import '../../../../data_builders/order_databuilder.dart';
import '../../../core/bindings/orders_test_bindings.dart';

class OrdersRepoTests {
  void unit() {
    var testConfig = Get.put(OrdersTestBindings());
    late IOrdersRepo _repo;
    var _orderWithoutId;

    setUp(() {
      testConfig.bindingsBuilder(isWidgetTest: true, isEmptyDb: false);
      _repo = Get.find<IOrdersRepo>();
      _orderWithoutId = OrderDatabuilder().Order_full_withoutId();
    });

    tearDown(Get.reset);

    test('Getting Orders - ResponseType', () {
      _repo.getOrders().then((value) {
        expect(value, isA<List<Order>>());
      });
    });

    test('Getting Orders', () {
      _repo.getOrders().then((response) {
        expect(response[0].id, "-MLszdOBBsXxJaPuwZqE");
        expect(response[0].cartItems[0].id, "-MJ45uFapLqamB92wOYe");
        expect(response[0].cartItems[1].id, "-MJDo1SL6ywrEs6AGrxB");
        expect(response[1].id, '-MKaVMmT4Z7SYHhg-S27');
        expect(response[1].cartItems[0].id, "-MKML9enBe3N13QRQKPF");
        expect(response[1].cartItems[1].id, "-MKML9enBe3N13QRQWSV");
      });
    });

    test('Adding Order', () {
      var id = Faker().randomGenerator.string(20, min: 20);
      _repo.addOrder(_orderWithoutId).then((response) {
        response = _orderWithoutId;
        response.id = id;
        expect(response.id, id);
      });
    });
  }
}