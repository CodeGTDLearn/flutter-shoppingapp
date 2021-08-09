import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/orders/entities/order.dart';
import 'package:shopingapp/app/modules/orders/repo/i_orders_repo.dart';

import '../../../../config/bindings/orders_test_bindings.dart';
import '../../../../data_builders/order_databuilder.dart';

class OrdersRepoTests {
  static void unit() {
    var testConfig = Get.put(OrdersTestBindings());
    late IOrdersRepo _repo;
    var _orderWithoutId;

    setUp(() {
      testConfig.bindingsBuilderMockedRepo(isWidgetTest: true);
      _repo = Get.find<IOrdersRepo>();
      // _injectRepo = OrdersInjectMockedRepo();
      _orderWithoutId = OrderDatabuilder.OrderFull();
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
// test('Getting Orders - No response Content (Empty)', () {
//   when(_injectRepo.getOrders()).thenAnswer((_) async => []);
//   _injectRepo.getOrders().then((value) {
//     expect(value, isEmpty);
//   });
// });

// test('Updating a Product(Inject) - status 500', () {
//   when(_injectRepo.getOrders()).thenAnswer((_) async => 500);
//   _injectRepo.getOrders().then((value) => {expect(value, 500)});
// });
