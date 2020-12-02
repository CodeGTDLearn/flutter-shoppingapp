import 'package:shopingapp/app/pages_modules/orders/controller/i_orders_controller.dart';
import 'package:shopingapp/app/pages_modules/orders/controller/orders_controller.dart';
import 'package:shopingapp/app/pages_modules/orders/repo/i_orders_repo.dart';
import 'package:shopingapp/app/pages_modules/orders/service/i_orders_service.dart';
import 'package:shopingapp/app/pages_modules/orders/service/orders_service.dart';
import 'package:test/test.dart';

import '../../../mocked_data_source/orders_mocked_data.dart';
import '../orders/repo/orders_repo_mocks.dart';

class OrdersControllerTest {
  static void integrationTests() {
    IOrdersRepo _mockedRepo;
    IOrdersService _service;
    IOrdersController _controller;

    setUp(() {
      _mockedRepo = OrdersMockRepo();
      _service = OrdersService(repo: _mockedRepo);
      _controller = OrdersController(service: _service);
    });

    test('Checking Instances to be used in the Tests', () {
      expect(_mockedRepo, isA<OrdersMockRepo>());
      expect(_service, isA<OrdersService>());
      expect(_controller, isA<OrdersController>());
    });

    test('Getting ALL Orders', () {
      expect(_controller.getQtdeOrdersObs(), isZero);
      expect(_controller.getOrdersObs().length, isZero);

      _controller.getOrders().forEach((value) {
        expect(value.id.toString(), isIn(OrdersMockedData().orders
          ()));
        expect(_controller.getQtdeOrdersObs(), isNonZero);
        expect(_controller.getOrdersObs().length, isNonZero);
      });
    });

    test('Clearing Orders with clearOrders', () {
      _controller.getOrders().forEach((value) {
        expect(_controller.getQtdeOrdersObs(), isZero);
        expect(_controller.getOrdersObs().length, isZero);
        expect(value.id.toString(), isIn(OrdersMockedData().orders()));
        expect(_controller.getQtdeOrdersObs(), isNonZero);
        expect(_controller.getOrdersObs().length, isNonZero);
        _controller.clearOrders();
        expect(_controller.getQtdeOrdersObs(), isZero);
        expect(_controller.getOrdersObs().length, isZero);
      });
    });
  }
}
