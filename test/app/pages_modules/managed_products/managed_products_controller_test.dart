import 'package:faker/faker.dart';
import 'package:shopingapp/app/pages_modules/managed_products/controller/i_managed_products_controller.dart';
import 'package:shopingapp/app/pages_modules/managed_products/controller/managed_products_controller.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/managed_products/repo/i_managed_products_repo.dart';
import 'package:shopingapp/app/pages_modules/managed_products/service/i_managed_products_service.dart';
import 'package:shopingapp/app/pages_modules/managed_products/service/managed_products_service.dart';
import 'package:test/test.dart';

import '../../../data_builders/product_databuilder.dart';
import '../../../mocked_data_source/products_mocked_data.dart';
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

    test('Checking Instances to be used in the Tests', () {
      expect(_mockRepo, isA<ManagedProductsMockRepo>());
      expect(_service, isA<ManagedProductsService>());
      expect(_controller, isA<ManagedProductsController>());
      expect(_product0, isA<Product>());
      expect(_product1, isA<Product>());
    });

    test('Checking Response Type in GetProducts', () {
      _controller.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('Checking getProducts + getManagedProductsObs loading', () {
      _controller.getProducts().then((_) {
        var list = _controller.getManagedProductsObs();
        expect(list[0].id, _products.elementAt(0).id);
        expect(list[0].title, _products.elementAt(0).title);
      });
    });

    test('Adding Product + Returning that', () {
      _controller.getProducts().then((value) {
        expect(_newProduct, isNot(isIn(_controller.getManagedProductsObs())));
        _controller.addProduct(_newProduct).then((response) {
          expect(response.id, _newProduct.id);
          expect(response.title, _newProduct.title);
          expect(response, isIn(_controller.getManagedProductsObs()));
        });
      });
    });

    test('Checking managedProductsQtde', () {
      _controller.getProducts().then((value) {
        expect(_newProduct, isNot(isIn(_controller.getManagedProductsObs())));
        expect(_controller.managedProductsQtde(), 4);
        _controller.addProduct(_newProduct).then((response) {
          expect(_controller.managedProductsQtde(), 5);
        });
      });
    });

    test('Getting ProductById', () {
      _controller.getProducts().then((value) {
        expect(_newProduct, isNot(isIn(_controller.getManagedProductsObs())));
        _controller.addProduct(_newProduct).then((response) {
          expect(response.id, _newProduct.id);
          expect(response.title, _newProduct.title);
          expect(response, isIn(_controller.getManagedProductsObs()));
          expect(_controller.getProductById(_newProduct.id),
              isIn(_controller.getManagedProductsObs()));
          expect(_controller.getProductById(_newProduct.id).id, _newProduct.id);
        });
      });
    });

    test('Getting ProductById - Fail', () {
      _controller.getProducts().then((_) {
        expect(() => _controller.getProductById(_newProduct.id),
            throwsA(isA<RangeError>()));
      });
    });

    test('Deleting Product', () {
      _controller.getProducts().then((_) {
        expect(_controller.getProductById(_product1.id),
            isIn(_controller.getManagedProductsObs()));
        _controller.deleteProduct(_product1.id).then((response) {
          expect(response, 200);
        });
      });
    });

    test('Updating Product', () {
      _controller.getProducts().then((_) {
        expect(_controller.getProductById(_product1.id),
            isIn(_controller.getManagedProductsObs()));
        _controller.updateProduct(_product1).then((response) {
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

    test('Deleting Product - Product not found - fail', () {
      _controller.getProducts().then((_) {
        expect(_controller.getProductById(_product1.id),
            isIn(_controller.getManagedProductsObs()));
        expect(() => _controller.deleteProduct(_newProduct.id),
            throwsA(isA<RangeError>()));
      });
    });

    test('Testing getReloadManagedProductsEditPage()', () {
      _controller.getProducts().then((_) {
        expect(_controller.getReloadManagedProductsEditPage(), isFalse);
        _controller.reloadManagedProductsAddEditPage();
        expect(_controller.getReloadManagedProductsEditPage(), isTrue);
      });
    });
  }
}
