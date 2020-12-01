import 'dart:async';

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/orders/entities/order.dart';
import 'package:shopingapp/app/pages_modules/orders/repo/i_orders_repo.dart';
import 'package:test/test.dart';

import '../../../../data_builders/order_databuilder.dart';
import 'orders_repo_mocks.dart';

class OrdersRepoTest {
  static void unitTests() {
    IOrdersRepo _mockRepo, _injectableMock;
    var _orderWithoutId;

    setUp(() {
      _mockRepo = OrdersMockRepo();
      _injectableMock = OrdersInjectableMockRepo();
      _orderWithoutId = OrderDatabuilder.OrderFull();
    });

    test('Checking Instances to be used in the Tests', () {
      expect(_mockRepo, isA<OrdersMockRepo>());
      expect(_injectableMock, isA<OrdersInjectableMockRepo>());
      expect(_orderWithoutId, isA<Order>());
    });

    test('Checking Response Type in getOrders', () {
      _mockRepo.getOrders().then((value) {
        expect(value, isA<List<Order>>());
      });
    });

    test('Getting Orders', () {
      _mockRepo.getOrders().then((response) {
        expect(response[0].id, "-MLszdOBBsXxJaPuwZqE");
        expect(response[0].cartItems[0].id, "-MJ45uFapLqamB92wOYe");
        expect(response[0].cartItems[1].id, "-MJDo1SL6ywrEs6AGrxB");
        expect(response[1].id, '-MKaVMmT4Z7SYHhg-S27');
        expect(response[1].cartItems[0].id, "-MKML9enBe3N13QRQKPF");
        expect(response[1].cartItems[1].id, "-MKML9enBe3N13QRQWSV");
      });
    });

    test('Adding Orders', () {
      var id = Faker().randomGenerator.string(20, min: 20);
      _mockRepo.addOrder(_orderWithoutId).then((response) {
        response = _orderWithoutId;
        response.id = id;
        expect(response.id, id);
      });
    });

    test('Getting Orders - No response Content (null)', () {
      when(_injectableMock.getOrders()).thenAnswer((_) async => []);
      _injectableMock.getOrders().then((value) {
        expect(value, isEmpty);
      });
    });

    test('Getting Orders - No response Content (empty)', () {
      when(_injectableMock.getOrders()).thenAnswer((_) async => null);
      _injectableMock.getOrders().then((value) {
        expect(value, isNull);
      });
    });
  }
}
