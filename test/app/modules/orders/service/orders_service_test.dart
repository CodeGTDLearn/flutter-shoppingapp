import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/modules/orders/entities/order.dart';
import 'package:shopingapp/app/modules/orders/service/i_orders_service.dart';
import 'package:test/test.dart';

import '../../../../data_builders/cartitem_databuilder.dart';
import '../../../../data_builders/order_databuilder.dart';
import '../orders_test_config.dart';
import 'orders_mocked_service.dart';

class OrdersServiceTests {
  static void unit() {
    IOrdersService _service, _injectService;
    var _cartItems;
    var testConfig = Get.put(OrdersTestConfig());

    setUp(() {
      testConfig.bindingsBuilderMockedRepo(execute: true);
      _service = Get.find<IOrdersService>();
      _injectService = OrdersInjectMockedService();
      _cartItems = CartItemDatabuilder.cartItems();
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

    test('Adding Order', () {
      var _id = "-${Faker().randomGenerator.string(21, min: 20)}";
      var _amountOrder = double.parse(
          Faker().randomGenerator.decimal(min: 22.0).toStringAsFixed(2));

      // @formatter:off
      when(
          _injectService
          .addOrder(_cartItems, _amountOrder))
          .thenAnswer((_) async =>
           OrderDatabuilder.OrderParam(_cartItems, _id));

          _injectService
          .addOrder(_cartItems, _amountOrder)
          .then((orderReturned) {
            expect(orderReturned.id, _id);
            expect(orderReturned.cartItems[0].id, _cartItems[0].id);
            expect(orderReturned.cartItems[1].id, _cartItems[1].id);
      });
    });
    // @formatter:on
  }
}
