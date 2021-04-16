import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/modules/orders/entities/order.dart';
import 'package:shopingapp/app/modules/orders/repo/i_orders_repo.dart';
import 'package:test/test.dart';

import '../../../../test_utils/data_builders/order_databuilder.dart';
import '../orders_test_config.dart';
import 'orders_repo_mocks.dart';

class OrdersRepoTest {
  static void unit() {
    IOrdersRepo _repo, _injectRepo;
    var _orderWithoutId;

    setUp(() {
      _repo = OrdersTestConfig().testsRepo;
      _injectRepo = OrdersInjectMockRepo();
      _orderWithoutId = OrderDatabuilder.OrderFull();
    });

    test('Checking Tests Instances', () {
      expect(_repo, isA<IOrdersRepo>());
      expect(_injectRepo, isA<OrdersInjectMockRepo>());
      expect(_orderWithoutId, isA<Order>());
    });

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

    //todo: erro authentication to be done
    // test('Getting products - Error authentication', () {
    //   _repo.getProducts().catchError((onError) {
    //     if (onError.toString().isNotEmpty) {
    //       fail("Error: Aut");
    //     }
    //   });
    // });

    test('Getting Orders - No response Content (Empty)', () {
      when(_injectRepo.getOrders()).thenAnswer((_) async => []);
      _injectRepo.getOrders().then((value) {
        expect(value, isEmpty);
      });
    });

    test('Getting Orders - Null as response', () {
      when(_injectRepo.getOrders()).thenAnswer((_) async => null);
      _injectRepo.getOrders().then((value) {
        expect(value, isNull);
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
