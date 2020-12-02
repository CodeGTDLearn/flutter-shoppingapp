import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/managed_products/repo/i_managed_products_repo.dart';
import 'package:test/test.dart';

import '../../../../mocked_data_source/products_mocked_data.dart';
import 'managed_products_repo_mocks.dart';

class ManagedProductsRepoTest {
  static void unitTests() {
    IManagedProductsRepo _mockRepo, _injectableMock;
    var _product0 = ProductsMockedData().products().elementAt(0);
    var _product1 = ProductsMockedData().products().elementAt(1);

    setUp(() {
      _mockRepo = ManagedProductsMockRepo();
      _injectableMock = ManagedProductsInjectMockRepo();
    });

    test('Checking Instances to be used in the Tests', () {
      expect(_mockRepo, isA<ManagedProductsMockRepo>());
      expect(_injectableMock, isA<ManagedProductsInjectMockRepo>());
      expect(_product0, isA<Product>());
      expect(_product1, isA<Product>());
    });

    test('Getting Managed Products', () {
      _mockRepo.getProducts().then((response) {
        expect(response, isA<List<Product>>());
        expect(response[0].id, _product0.id);
        expect(response[0].title, _product0.title);
        expect(response[1].id, _product1.id);
        expect(response[1].title, _product1.title);
      });
    });

    test('Adding Managed Product', () {
      _mockRepo.addProduct(_product0).then((response) {
        expect(response.id, _product0.id);
      });
    });

    test('Adding Managed Product - No response Content (Empty)', () {
      when(_injectableMock.getProducts()).thenAnswer((_) async => []);
      _injectableMock.getProducts().then((value) {
        expect(value, isEmpty);
      });
    });

    test('Adding Managed Product - Null as response', () {
      when(_injectableMock.getProducts()).thenAnswer((_) async => null);
      _injectableMock.getProducts().then((value) {
        expect(value, isNull);
      });
    });

    test('Updating Managed Product', () {
      _mockRepo.addProduct(_product0).then((response) {
        expect(response.id, _product0.id);
        expect(response.title, _product0.title);
        _mockRepo.updateProduct(_product0).then((value) {
          expect(value, 200);
        });
      });
    });

    test('Updating a Product - Response Status 404', () {
      when(_injectableMock.updateProduct(_product0))
          .thenAnswer((_) async => 404);

      _injectableMock
          .updateProduct(_product0)
          .then((value) => {expect(value, 404)});
    });

    test('Deleting Managed Product', () {
      _mockRepo.getProducts().then((response) {
        expect(response, isA<List<Product>>());
        expect(response[0].id, _product0.id);
        expect(response[0].title, _product0.title);

        _mockRepo.deleteProduct(_product0.id).then((value) {
          expect(value, 200);
          expect(response[0].id, isNot(isIn(response)));
        });
      });
    });

    test('Deleting a Product - Response Status 404', () {
      when(_injectableMock.deleteProduct(_product0.id))
          .thenAnswer((_) async => 404);

      _injectableMock
          .deleteProduct(_product0.id)
          .then((value) => {expect(value, 404)});
    });
  }
}
