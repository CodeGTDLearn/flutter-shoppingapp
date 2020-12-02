import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/managed_products/repo/i_managed_products_repo.dart';
import 'package:shopingapp/app/pages_modules/managed_products/service/i_managed_products_service.dart';
import 'package:shopingapp/app/pages_modules/managed_products/service/managed_products_service.dart';
import 'package:shopingapp/app/pages_modules/orders/entities/order.dart';
import 'package:test/test.dart';

import '../../../../mocked_data_source/products_mocked_data.dart';
import '../repo/managed_products_repo_mocks.dart';
import 'managed_products_service_mock.dart';

class ManagedProductsServiceTest {
  static void unitTests() {
    IManagedProductsService _service, _injectableMockService;
    IManagedProductsRepo _mockRepo;
    var _product0 = ProductsMockedData().products().elementAt(0);
    var _product1 = ProductsMockedData().products().elementAt(1);
    setUp(() {
      _mockRepo = ManagedProductsMockRepo();
      _service = ManagedProductsService(repo: _mockRepo);
      _injectableMockService = ManagedProductsInjectMockService();
    });

    test('Checking Instances to be used in the Tests', () {
      expect(_mockRepo, isA<ManagedProductsMockRepo>());
      expect(_service, isA<ManagedProductsService>());
      expect(_injectableMockService, isA<ManagedProductsInjectMockService>());
      expect(_product0, isA<Product>());
      expect(_product1, isA<Product>());
    });

    test('Checking Response Type in GetProducts', () {
      _service.getProducts().then((value) {
        expect(value, isA<List<Order>>());
      });
    });

    // test('Checking getOrders loading', () {
    //   _service.getOrders().then((listReturn) {
    //     expect(listReturn[0].id, "-MLszdOBBsXxJaPuwZqE");
    //     expect(listReturn[0].datetime, "2020-10-12T16:37:06.983506");
    //     expect(listReturn[0].amount, "100.00");
    //     expect(listReturn[0].cartItems[0].id, "-MJ45uFapLqamB92wOYe");
    //     expect(listReturn[0].cartItems[0].title, "Red Shirt");
    //   });
    // });

    // test('Checking getLocalDataOrders loading', () {
    //   _service.getOrders().then((_) {
    //     var list = _service.getLocalDataOrders();
    //     expect(list[0].id, "-MLszdOBBsXxJaPuwZqE");
    //     expect(list[0].datetime, "2020-10-12T16:37:06.983506");
    //     expect(list[0].amount, "100.00");
    //     expect(list[0].cartItems[0].id, "-MJ45uFapLqamB92wOYe");
    //     expect(list[0].cartItems[0].title, "Red Shirt");
    //   });
    // });
    //
    // test('Adding Orders', () {
    //   var _id = "-${Faker().randomGenerator.string(21, min: 20)}";
    //   var _amountOrder = double.parse(
    //       Faker().randomGenerator.decimal(min: 22.0).toStringAsFixed(2));
    //
    //   // @formatter:off
    //   when(
    //       _injectableMockService
    //       .addOrder(_cartItems, _amountOrder))
    //       .thenAnswer((_) async =>
    //        OrderDatabuilder.OrderParam(_cartItems, _id));
    //
    //       _injectableMockService
    //       .addOrder(_cartItems, _amountOrder)
    //       .then((orderReturned) {
    //         expect(orderReturned.id, _id);
    //         expect(orderReturned.cartItems[0].id, _cartItems[0].id);
    //         expect(orderReturned.cartItems[1].id, _cartItems[1].id);
    //   });
    // });
    // @formatter:on
  }
}
