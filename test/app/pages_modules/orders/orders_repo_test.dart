import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/orders/entities/order.dart';
import 'package:shopingapp/app/pages_modules/orders/repo/i_orders_repo.dart';
import 'package:test/test.dart';

import 'orders_repo_mocks.dart';

class OrdersRepoTest {
  static void unitTests() {
    IOrdersRepo _mockRepo, _injectableMock;
    var _productFail;

    // setUpAll(() {
    //   _productFail = ProductDataBuilder().ProductId();
    // });

    setUp(() {
      _mockRepo = OrdersMockRepo();
      _injectableMock = OrdersInjectableMockRepo();
    });

      test('Checking Instances to be used in the Test', () {
        expect(_mockRepo, isA<OrdersMockRepo>());
        expect(_injectableMock, isA<OrdersInjectableMockRepo>());
        // expect(_productFail, isA<Product>());
      });

      test('Checking Response Type in getOrders', () {
        _mockRepo.getOrders().then((value) {
          expect(value, isA<List<Order>>());
        });
      });

    test('Getting Orders', () {
      _mockRepo.getOrders().then((value) {
        expect(value[0].id, "-MLszdOBBsXxJaPuwZqE");
        expect(value[0].cartItems[0].id, "-MJ45uFapLqamB92wOYe");
        expect(value[0].cartItems[1].id, "-MJDo1SL6ywrEs6AGrxB");
        expect(value[1].id, '-MKaVMmT4Z7SYHhg-S27');
        expect(value[1].cartItems[0].id, "-MKML9enBe3N13QRQKPF");
        expect(value[1].cartItems[1].id, "-MKML9enBe3N13QRQWSV");
      });
    });

    test('Getting Orders - Fail hence Empty', () {
      when(_injectableMock.getOrders()).thenAnswer((_) async => []);

      _injectableMock.getOrders().then((value) {
        expect(value, isEmpty);
      });
    });
    //
      // test('Updating a Product - Response Status 404', () {
      //   when(_injectableMock.updateProduct(_productFail))
      //       .thenAnswer((_) async => 404);
      //
      //   _injectableMock
      //       .updateProduct(_productFail)
      //       .then((value) => {expect(value, 404)});
      // });
  }
}
