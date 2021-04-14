import 'package:shopingapp/app/modules/inventory/controller/inventory_controller.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/inventory/repo/i_inventory_repo.dart';
import 'package:shopingapp/app/modules/inventory/service/i_inventory_service.dart';
import 'package:shopingapp/app/modules/inventory/service/inventory_service.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/service/overview_service.dart';
import 'package:test/test.dart';

import '../../../test_utils/data_builders/product_databuilder.dart';
import '../../../test_utils/mocked_datasource/products_mocked_datasource.dart';
import '../../../test_utils/test_utils.dart';
import '../overview/repo/overview_repo_mocks.dart';
import 'repo/managed_products_repo_mocks.dart';

class ManagedProductsControllerTest {
  static void integration() {
    IOverviewService _ovService;
    IOverviewRepo _mockRepoOverviewProducts;
    InventoryController _controller;
    IInventoryService _service;
    IInventoryRepo _mockRepoManagedProducts;
    var _product0 = ProductsMockedDatasource().products().elementAt(0);
    var _product1 = ProductsMockedDatasource().products().elementAt(1);
    var _products = ProductsMockedDatasource().products();
    var _newProduct = ProductDataBuilder().ProductFull();

    setUp(() {
      _mockRepoOverviewProducts = OverviewMockRepo();
      _ovService = OverviewService(repo: _mockRepoOverviewProducts);

      _mockRepoManagedProducts = ManagedProductsMockRepo();
      _service = InventoryService(
        repo: _mockRepoManagedProducts,
        overviewService: _ovService,
      );
      _controller = InventoryController(service: _service);
    });

    tearDown(TestMethods.globalTearDown);

    test('Checking Test Instances', () {
      expect(_mockRepoManagedProducts, isA<ManagedProductsMockRepo>());
      expect(_service, isA<InventoryService>());
      expect(_controller, isA<InventoryController>());
      expect(_product0, isA<Product>());
      expect(_product1, isA<Product>());
    });

    test('Getting Products - ResponseType', () {
      _controller.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('Getting using GetManagedProductsObs', () {
      _controller.getProducts().then((_) {
        var list = _controller.getManagedProductsObs();
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
        expect(_newProduct, isNot(isIn(_controller.getManagedProductsObs())));
        expect(_controller.managedProductsQtde(), 4);
        _controller.addProduct(_newProduct).then((response) {
          expect(_controller.managedProductsQtde(), 5);
        });
      });
    });

    test('Getting ProductById', () {
      // @formatter:off
      _controller.getProducts().then((products) {
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
      _ovService.getProducts().then((_) {
        expect(
          _ovService.getProductById(_product1.id),
          isIn(_ovService.getLocalDataAllProducts()),
        );
      });
      _controller.getProducts().then((_) {
        expect(_controller.getProductById(_product1.id),
            isIn(_controller.getManagedProductsObs()));
        _controller.updateProduct(_product1).then((response) {
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
      _controller.getProducts().then((_) {
        expect(
          _newProduct.id,
          isNot(isIn(_controller.getManagedProductsObs())),
        );
        _controller.updateProduct(_newProduct).then((response) {
          expect(response, 500);
        });
      });
    });

    test('Updating ManagedProductsObs', () {
      var productTest = ProductsMockedDatasource().product();

      _controller.getProducts().then((value) {
        expect(_service.getLocalDataManagedProducts().length, 4);
        _service.addLocalDataManagedProducts(productTest);
        expect(_service.getLocalDataManagedProducts().length, 5);

        expect(_controller.getManagedProductsObs().length, 4);
        _controller.updateManagedProductsObs();
        expect(_controller.getManagedProductsObs().length, 5);
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
        _controller.switchManagedProdAddEditFormToCustomCircularProgrIndic();
        expect(_controller.getReloadManagedProductsEditPageObs(), isTrue);
      });
    });
  }
}