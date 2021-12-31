import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/inventory/controller/inventory_controller.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';
import 'package:shopingapp/app/modules/inventory/service/i_inventory_service.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';

import '../../../data_builders/product_databuilder.dart';
import '../../../datasource/mocked_datasource.dart';
import '../../core/bindings/inventory_test_bindings.dart';

class InventoryControllerTests {
  void integration() {
    late IOverviewService _overviewService;
    late IInventoryService _service;
    late InventoryController _controller;

    var _product0 = MockedDatasource().products().elementAt(0);
    var _product1 = MockedDatasource().products().elementAt(1);
    var _products = MockedDatasource().products();
    var _newProduct = ProductDataBuilder().ProductWithId();

    setUp(() {
      InventoryTestBindings().bindingsBuilder(isWidgetTest: true, isEmptyDb: false);
      _overviewService = Get.find<IOverviewService>();

      _service = Get.find<IInventoryService>();
      _controller = InventoryController(service: _service);
    });

    test('Getting Products - ResponseType', () {
      _controller.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('Getting using GetManagedProductsObs', () {
      _controller.getProducts().then((_) {
        var list = _controller.inventoryProductsObs.toList();
        expect(list[0].id, _products.elementAt(0).id);
        expect(list[0].title, _products.elementAt(0).title);
      });
    });

    test('Adding a Product', () {
      // @formatter:off
      _controller.getProducts().then((value) {
        _controller.addProduct(_product0).then((addedProduct) {
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
        expect(_newProduct, isNot(isIn(_controller.inventoryProductsObs.toList())));
        expect(_controller.getProductsQtde(), 4);
        _controller.addProduct(_newProduct).then((response) {
          expect(_controller.getProductsQtde(), 5);
        });
      });
    });

    test('Getting ProductById', () {
      // @formatter:off
      _controller.getProducts().then((products) {
        var found = _controller.getProductById(products[0].id!);
        expect(found.id, _product0.id);
        expect(found.title, _product0.title);
        expect(found, isIn(_controller.inventoryProductsObs.toList()));
      });
      // @formatter:on
    });

    test('Getting ProductById - Exception', () {
      _controller.getProducts().then((_) {
        expect(() => _controller.getProductById(_newProduct.id!),
            throwsA(isA<RangeError>()));
      });
    });

    test('Updating a Product - status 200', () {
      _overviewService.getProducts().then((_) {
        expect(
          _overviewService.getProductById(_product1.id!),
          isIn(_overviewService.getLocalDataAllProducts()),
        );
      });
      _controller.getProducts().then((_) {
        expect(_controller.getProductById(_product1.id!),
            isIn(_controller.inventoryProductsObs.toList()));
        _controller.updateProduct(_product1).then((response) {
          expect(response, 200);
        });
      });
    });

    test('Updating a Product - status 500', () {
      _controller.getProducts().then((_) {
        expect(
          _newProduct.id,
          isNot(isIn(_controller.inventoryProductsObs.toList())),
        );
        _newProduct;
        _controller.updateProduct(_newProduct).then((response) {
          expect(response, 500);
        });
      });
    });

    test('Updating ManagedProductsObs', () {
      var productTest = MockedDatasource().product();

      _controller.getProducts().then((value) {
        expect(_service.getLocalDataInventoryProducts().length, 4);
        _service.addLocalDataInventoryProducts(productTest);
        expect(_service.getLocalDataInventoryProducts().length, 5);

        expect(_controller.inventoryProductsObs.toList().length, 4);
        _controller.updateInventoryProductsObs();
        expect(_controller.inventoryProductsObs.toList().length, 5);
      });
    });

    test('Deleting Product - status 200', () {
      _controller.getProducts().then((_) {
        expect(_controller.getProductById(_product1.id!),
            isIn(_controller.inventoryProductsObs.toList()));
        _controller.deleteProduct(_product1.id!).then((response) {
          expect(response, 200);
        });
      });
    });

    test('Deleting Product - Optimistic/Rollback', () {
      _controller.getProducts().then((_) {
        expect(_controller.getProductById(_product1.id!),
            isIn(_controller.inventoryProductsObs.toList()));
        _controller.deleteProduct(_product1.id!).then((response) {
          expect(response, 200);
        });
      });
    });

    test('Deleting a Product - Not found - Exception', () {
      _controller.getProducts().then((_) {
        expect(_controller.getProductById(_product1.id!),
            isIn(_controller.inventoryProductsObs.toList()));
        expect(
            () => _controller.deleteProduct(_newProduct.id!), throwsA(isA<RangeError>()));
      });
    });

    test('Testing getReloadManagedProductsEditPage', () {
      _controller.getProducts().then((_) {
        expect(_controller.renderInventoryItemDetailsViewObs.value, isFalse);
        _controller.switchInventoryItemFormToCustomIndicator();
        expect(_controller.renderInventoryItemDetailsViewObs.value, isTrue);
      });
    });
  }
}