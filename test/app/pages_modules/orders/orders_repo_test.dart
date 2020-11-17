import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/orders/repo/i_orders_repo.dart';
import 'package:test/test.dart';

import 'orders_repo_mocks.dart';

class OrdersRepoTest {
  static void unitTests() {
    IOrdersRepo _mockRepo, _injectableMock;
    var _productFail;

    setUpAll(() {
      _productFail = ProductDataBuilder().ProductId();
    });

    setUp(() {
      _mockRepo = OrdersMockRepo();
      _injectableMock = OrdersInjectableMockRepo();
    });

      test('Checking Instances to be used in the Test', () {
        expect(_mockRepo, isA<OrdersMockRepo>());
        expect(_injectableMock, isA<OrdersInjectableMockRepo>());
        expect(_productFail, isA<Product>());
      });

      test('Checking Response Type in GetProducts', () {
        _mockRepo.getProducts().then((value) {
          expect(value, isA<List<Product>>());
        });
      });

    // group('Injectable-Mocked-Repo', () {
      test('Checking Instances to be used in the Test', () {
        expect(_injectableMock, isA<OverviewInjectableMockRepo>());
      });

      test('Getting products - Fail hence Empty', () {
        when(_injectableMock.getProducts()).thenAnswer((_) async => []);

        _injectableMock.getProducts().then((value) {
          expect(value, isEmpty);
        });
      });

      test('Updating a Product - Response Status 404', () {
        when(_injectableMock.updateProduct(_productFail))
            .thenAnswer((_) async => 404);

        _injectableMock
            .updateProduct(_productFail)
            .then((value) => {expect(value, 404)});
      });

      test('Getting products - Fail hence Null response', () {
        when(_injectableMock.getProducts()).thenAnswer((_) async => null);

        _injectableMock
            .getProducts()
            .then((value) => expect(value, isNull));
      });
  }
}
