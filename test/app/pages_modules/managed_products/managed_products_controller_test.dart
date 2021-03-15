import 'package:shopingapp/app/pages_modules/managed_products/controller/i_managed_products_controller.dart';
import 'package:shopingapp/app/pages_modules/managed_products/controller/managed_products_controller.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/managed_products/repo/i_managed_products_repo.dart';
import 'package:shopingapp/app/pages_modules/managed_products/service/i_managed_products_service.dart';
import 'package:shopingapp/app/pages_modules/managed_products/service/managed_products_service.dart';
import 'package:test/test.dart';

import '../../../test_utils/custom_test_methods.dart';
import '../../../test_utils/data_builders/product_databuilder.dart';
import '../../../test_utils/mocked_data/mocked_products_data.dart';
import 'repo/managed_products_repo_mocks.dart';

class ManagedProductsControllerTest {
  static void integration() {
    IManagedProductsController _controller;
    IManagedProductsService _service;
    IManagedProductsRepo _mockRepo;
    var _product0 = ProductsMockedData().products().elementAt(0);
    var _product1 = ProductsMockedData().products().elementAt(1);
    var _products = ProductsMockedData().products();
    var _newProduct = ProductDataBuilder().ProductFull();

    setUp(() {
      _mockRepo = ManagedProductsMockRepo();
      _service = ManagedProductsService(repo: _mockRepo);
      _controller = ManagedProductsController(service: _service);
    });

    tearDown(CustomTestMethods.globalTearDown);

    test('Checking Test Instances', () {
      expect(_mockRepo, isA<ManagedProductsMockRepo>());
      expect(_service, isA<ManagedProductsService>());
      expect(_controller, isA<ManagedProductsController>());
      expect(_product0, isA<Product>());
      expect(_product1, isA<Product>());
    });

    test('Getting Products - ResponseType', () {
      _controller.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('Getting Products (getManagedProductsObs)', () {
      _controller.getProducts().then((_) {
        var list = _controller.getManagedProductsObs();
        expect(list[0].id, _products.elementAt(0).id);
        expect(list[0].title, _products.elementAt(0).title);
      });
    });

    test('Adding a Product', () {
      // @formatter:off
      _controller.getProducts().then((value) {
        _controller
            .addProduct(_product0)
            .then((addedProduct) {
                // In addProduct, never the 'product to be added' has 'id'
                // expect(addedProduct.id, _product0.id);
                expect(addedProduct.title, _product0.title);
                expect(addedProduct.price, _product0.price);
                expect(addedProduct.description, _product0.description);
                expect(addedProduct.imageUrl, _product0.imageUrl);
                expect(addedProduct.isFavorite, _product0.isFavorite);
            });
      });
      // @formatter:on
    });

    test('Getting ProductsQtde', () {
      _controller.getProducts().then((value) {
        expect(_newProduct, isNot(isIn(_controller.getManagedProductsObs())));
        expect(_controller.managedProductsQtde(), 4);
        _controller.addProduct(_newProduct).then((response) {
          expect(_controller.managedProductsQtde(), 5);
        });
      });
    });

    test('Getting ProductById', () {
      // @formatter:off
      _controller
          .getProducts()
          .then((products) {
              var found = _controller.getProductById(products[0].id);
              expect(found.id, _product0.id);
              expect(found.title, _product0.title);
              expect(found, isIn(_controller.getManagedProductsObs()));
          });
      // @formatter:on
    });

    test('Getting ProductById - Exception', () {
      _controller.getProducts().then((_) {
        expect(() => _controller.getProductById(_newProduct.id),
            throwsA(isA<RangeError>()));
      });
    });

    test('Updating a Product - status 200', () {
      _controller.getProducts().then((_) {
        expect(_controller.getProductById(_product1.id),
            isIn(_controller.getManagedProductsObs()));
        _controller.updateProduct(_product1).then((response) {
          expect(response, 200);
        });
      });
    });

    test('Updating a Product - status 400', () {
      _controller.getProducts().then((_) {
        expect(
            _newProduct.id, isNot(isIn(_controller.getManagedProductsObs())));
        _controller.updateProduct(_newProduct).then((response) {
          expect(response, 400);
        });
      });
    });

    test('Deleting Product - status 200', () {
      _controller.getProducts().then((_) {
        expect(_controller.getProductById(_product1.id),
            isIn(_controller.getManagedProductsObs()));
        _controller.deleteProduct(_product1.id).then((response) {
          expect(response, 200);
        });
      });
    });

    test('Deleting Product - Optimistic/Rollback', () {
      _controller.getProducts().then((_) {
        expect(_controller.getProductById(_product1.id),
            isIn(_controller.getManagedProductsObs()));
        _controller.deleteProduct(_product1.id).then((response) {
          expect(response, 200);
        });
      });
    });

    test('Deleting a Product - Not found - Exception', () {
      _controller.getProducts().then((_) {
        expect(_controller.getProductById(_product1.id),
            isIn(_controller.getManagedProductsObs()));
        expect(() => _controller.deleteProduct(_newProduct.id),
            throwsA(isA<RangeError>()));
      });
    });

    test('Testing getReloadManagedProductsEditPage', () {
      _controller.getProducts().then((_) {
        expect(_controller.getReloadManagedProductsEditPageObs(), isFalse);
        _controller.switchManagedProdAddEditFormAndCustomCircularProgrIndic();
        expect(_controller.getReloadManagedProductsEditPageObs(), isTrue);
      });
    });
  }
}
