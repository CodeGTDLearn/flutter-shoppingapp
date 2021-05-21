import 'package:get/get.dart';
import 'package:shopingapp/app/modules/inventory/controller/inventory_controller.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/inventory/service/i_inventory_service.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:test/test.dart';

import '../../../data_builders/product_databuilder.dart';
import '../../../mocked_datasource/products_mocked_datasource.dart';
import 'inventory_test_config.dart';

class InventoryControllerTests {
  static void integration() {
    IOverviewService _ovService;

    IInventoryService _invService;
    InventoryController _invController;

    var _product0 = ProductsMockedDatasource().products().elementAt(0);
    var _product1 = ProductsMockedDatasource().products().elementAt(1);
    var _products = ProductsMockedDatasource().products();
    var _newProduct = ProductDataBuilder().ProductFull();

    setUp(() {
      InventoryTestConfig().bindingsBuilderMockedRepo(execute: true);
      _ovService = Get.find<IOverviewService>();

      _invService = Get.find<IInventoryService>();
      _invController = InventoryController(service: _invService);
    });

    test('Getting Products - ResponseType', () {
      _invController.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('Getting using GetManagedProductsObs', () {
      _invController.getProducts().then((_) {
        var list = _invController.getInventoryProductsObs();
        expect(list[0].id, _products.elementAt(0).id);
        expect(list[0].title, _products.elementAt(0).title);
      });
    });

    test('Adding a Product', () {
      // @formatter:off
      _invController.getProducts().then((value) {
        _invController.addProduct(_product0).then((addedProduct) {
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
      _invController.getProducts().then((value) {
        expect(_newProduct, isNot(isIn(_invController.getInventoryProductsObs())));
        expect(_invController.getProductsQtde(), 4);
        _invController.addProduct(_newProduct).then((response) {
          expect(_invController.getProductsQtde(), 5);
        });
      });
    });

    test('Getting ProductById', () {
      // @formatter:off
      _invController.getProducts().then((products) {
        var found = _invController.getProductById(products[0].id);
        expect(found.id, _product0.id);
        expect(found.title, _product0.title);
        expect(found, isIn(_invController.getInventoryProductsObs()));
      });
      // @formatter:on
    });

    test('Getting ProductById - Exception', () {
      _invController.getProducts().then((_) {
        expect(() => _invController.getProductById(_newProduct.id),
            throwsA(isA<RangeError>()));
      });
    });

    test('Updating a Product - status 200', () {
      _ovService.getProducts().then((_) {
        expect(
          _ovService.getProductById(_product1.id),
          isIn(_ovService.getLocalDataAllProducts()),
        );
      });
      _invController.getProducts().then((_) {
        expect(_invController.getProductById(_product1.id),
            isIn(_invController.getInventoryProductsObs()));
        _invController.updateProduct(_product1).then((response) {
          expect(response, 200);
        });
      });
    });

    test('Updating a Product - status 500', () {
      _ovService.getProducts().then((_) {
        expect(
          _ovService.getProductById(_product1.id),
          isIn(_ovService.getLocalDataAllProducts()),
        );
      });
      _invController.getProducts().then((_) {
        expect(
          _newProduct.id,
          isNot(isIn(_invController.getInventoryProductsObs())),
        );
        _invController.updateProduct(_newProduct).then((response) {
          expect(response, 500);
        });
      });
    });

    test('Updating ManagedProductsObs', () {
      var productTest = ProductsMockedDatasource().product();

      _invController.getProducts().then((value) {
        expect(_invService.getLocalDataInventoryProducts().length, 4);
        _invService.addLocalDataInventoryProducts(productTest);
        expect(_invService.getLocalDataInventoryProducts().length, 5);

        expect(_invController.getInventoryProductsObs().length, 4);
        _invController.updateInventoryProductsObs();
        expect(_invController.getInventoryProductsObs().length, 5);
      });
    });

    test('Deleting Product - status 200', () {
      _invController.getProducts().then((_) {
        expect(_invController.getProductById(_product1.id),
            isIn(_invController.getInventoryProductsObs()));
        _invController.deleteProduct(_product1.id).then((response) {
          expect(response, 200);
        });
      });
    });

    test('Deleting Product - Optimistic/Rollback', () {
      _invController.getProducts().then((_) {
        expect(_invController.getProductById(_product1.id),
            isIn(_invController.getInventoryProductsObs()));
        _invController.deleteProduct(_product1.id).then((response) {
          expect(response, 200);
        });
      });
    });

    test('Deleting a Product - Not found - Exception', () {
      _invController.getProducts().then((_) {
        expect(_invController.getProductById(_product1.id),
            isIn(_invController.getInventoryProductsObs()));
        expect(() => _invController.deleteProduct(_newProduct.id),
            throwsA(isA<RangeError>()));
      });
    });

    test('Testing getReloadManagedProductsEditPage', () {
      _invController.getProducts().then((_) {
        expect(_invController.getReloadInventoryProductsEditPageObs(), isFalse);
        _invController.switchInventoryAddEditFormToCustomCircularProgrIndic();
        expect(_invController.getReloadInventoryProductsEditPageObs(), isTrue);
      });
    });
  }
}
