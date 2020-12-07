import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/cart/entities/cart_item.dart';
import 'package:shopingapp/app/pages_modules/orders/entities/order.dart';
import 'package:shopingapp/app/pages_modules/orders/repo/i_orders_repo.dart';
import 'package:shopingapp/app/pages_modules/orders/service/i_orders_service.dart';
import 'package:shopingapp/app/pages_modules/orders/service/orders_service.dart';
import 'package:test/test.dart';

import '../../../../data_builders/cartitem_databuilder.dart';
import '../../../../data_builders/order_databuilder.dart';
import '../repo/orders_repo_mocks.dart';
import 'orders_service_mock.dart';

class OrdersServiceTest {
  static void unitTests() {
    IOrdersService _service, _injectMockService;
    IOrdersRepo _mockRepo;
    var _cartItems;

    setUp(() {
      _mockRepo = OrdersMockRepo();
      _service = OrdersService(repo: _mockRepo);
      _injectMockService = OrdersInjectMockService();
      _cartItems = CartItemDatabuilder.cartItems();
    });

    test('Checking Instances to be used in the Tests', () {
      expect(_service, isA<OrdersService>());
      expect(_mockRepo, isA<OrdersMockRepo>());
      expect(_injectMockService, isA<OrdersInjectMockService>());
      expect(_cartItems, isA<List<CartItem>>());
    });

    test('Checking Response Type in GetProducts', () {
      _service.getOrders().then((value) {
        expect(value, isA<List<Order>>());
      });
    });

    test('Checking getOrders loading', () {
      _service.getOrders().then((listReturn) {
        expect(listReturn[0].id, "-MLszdOBBsXxJaPuwZqE");
        expect(listReturn[0].datetime, "2020-10-12T16:37:06.983506");
        expect(listReturn[0].amount, "100.00");
        expect(listReturn[0].cartItems[0].id, "-MJ45uFapLqamB92wOYe");
        expect(listReturn[0].cartItems[0].title, "Red Shirt");
      });
    });

    test('Checking getLocalDataOrders loading', () {
      _service.getOrders().then((_) {
        var list = _service.getLocalDataOrders();
        expect(list[0].id, "-MLszdOBBsXxJaPuwZqE");
        expect(list[0].datetime, "2020-10-12T16:37:06.983506");
        expect(list[0].amount, "100.00");
        expect(list[0].cartItems[0].id, "-MJ45uFapLqamB92wOYe");
        expect(list[0].cartItems[0].title, "Red Shirt");
      });
    });

    test('Checking ordersQtde', () {
      _service.getOrders().then((listReturned) {
        var listLocalData = _service.getLocalDataOrders();
        expect(listLocalData.length, _service.ordersQtde());
        expect(listReturned.length, _service.ordersQtde());
      });
    });

    test('Checking clearOrders', () {
      _service.getOrders().then((_) {
        var list = _service.getLocalDataOrders();
        expect(list.length, _service.ordersQtde());
        _service.clearOrders();
        expect(_service.ordersQtde(), 0);
      });
    });

    test('Adding Orders', () {
      var _id = "-${Faker().randomGenerator.string(21, min: 20)}";
      var _amountOrder = double.parse(
          Faker().randomGenerator.decimal(min: 22.0).toStringAsFixed(2));

      // @formatter:off
      when(
          _injectMockService
          .addOrder(_cartItems, _amountOrder))
          .thenAnswer((_) async =>
           OrderDatabuilder.OrderParam(_cartItems, _id));

          _injectMockService
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
