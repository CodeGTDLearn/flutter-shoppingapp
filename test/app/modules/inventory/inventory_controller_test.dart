import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/inventory/controller/inventory_controller.dart';
import 'package:shopingapp/app/modules/inventory/service/i_inventory_service.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';

import '../../../config/data_builders/product_databuilder.dart';
import '../../../config/datasource/mocked_datasource.dart';
import 'core/inventory_test_bindings.dart';
import 'core/inventory_test_titles.dart';

class InventoryControllerTests {
  void integration() {
    late IOverviewService _overviewService;
    late IInventoryService _service;
    late InventoryController _controller;
    final _mock = Get.find<MockedDatasource>();
    final _builder = Get.find<ProductDataBuilder>();
    final _titles = Get.find<InventoryTestTitles>();

    var _product0, _product1, _newProduct;
    var _products;

    setUpAll(() {
      Get.create(() => InventoryTestBindings());
      var _bindings = Get.find<InventoryTestBindings>();
      _bindings.bindingsBuilder(isWidgetTest: true, isEmptyDb: false);

      _service = Get.find<IInventoryService>();
      _overviewService = Get.find<IOverviewService>();
      _controller = InventoryController(service: _service);
      _product0 = _mock.products().elementAt(0);
      _product1 = _mock.products().elementAt(1);
      _products = _mock.products();
      _newProduct = _builder.ProductWithId();
    });

    test(_titles.controller_GetManagedProductsObs, () {
      _controller.getProducts().then((_) {
        var list = _controller.inventoryProductsObs.toList();
        expect(list[0].id, _products.elementAt(0).id);
        expect(list[0].title, _products.elementAt(0).title);
      });
    });

    test(_titles.controller_add_product, () {
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

    test(_titles.controller_get_products_qtde, () {
      _controller.getProducts().then((value) {
        expect(_newProduct, isNot(isIn(_controller.inventoryProductsObs.toList())));
        expect(_controller.getProductsQtde(), 4);
        _controller.addProduct(_newProduct).then((response) {
          expect(_controller.getProductsQtde(), 5);
        });
      });
    });

    test(_titles.controller_get_product_by_id, () {
      // @formatter:off
      _controller.getProducts().then((products) {
        var found = _controller.getProductById(products[0].id!);
        expect(found.id, _product0.id);
        expect(found.title, _product0.title);
        expect(found, isIn(_controller.inventoryProductsObs.toList()));
      });
      // @formatter:on
    });

    test(_titles.controller_get_product_by_id_exc, () {
      _controller.getProducts().then((_) {
        expect(() => _controller.getProductById(_newProduct.id!),
            throwsA(isA<RangeError>()));
      });
    });

    test(_titles.controller_update_product, () {
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

    test(_titles.controller_update_product_status_500, () {
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

    test(_titles.controller_update_managed_products_obs, () {
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

    test(_titles.controller_delete_product_status_200, () {
      _controller.getProducts().then((_) {
        expect(_controller.getProductById(_product1.id!),
            isIn(_controller.inventoryProductsObs.toList()));
        _controller.deleteProduct(_product1.id!).then((response) {
          expect(response, 200);
        });
      });
    });

    test(_titles.controller_delete_transaction, () {
      _controller.getProducts().then((_) {
        expect(_controller.getProductById(_product1.id!),
            isIn(_controller.inventoryProductsObs.toList()));
        _controller.deleteProduct(_product1.id!).then((response) {
          expect(response, 200);
        });
      });
    });

    test(_titles.controller_delete_transaction_exc, () {
      _controller.getProducts().then((_) {
        expect(_controller.getProductById(_product1.id!),
            isIn(_controller.inventoryProductsObs.toList()));
        expect(
            () => _controller.deleteProduct(_newProduct.id!), throwsA(isA<RangeError>()));
      });
    });

    test(_titles.controller_reload_view, () {
      _controller.getProducts().then((_) {
        expect(_controller.renderInventoryItemDetailsViewObs.value, isFalse);
        _controller.switchInventoryItemFormToCustomIndicator();
        expect(_controller.renderInventoryItemDetailsViewObs.value, isTrue);
      });
    });
  }
}