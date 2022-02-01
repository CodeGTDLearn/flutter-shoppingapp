import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/inventory/service/i_inventory_service.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';

import '../../../config/titles/inventory_test_titles.dart';
import '../../../data_builders/product_databuilder.dart';
import '../../../datasource/mocked_datasource.dart';
import '../../core/bindings/inventory_test_bindings.dart';

class InventoryServiceTests {
  void unit() {
    late IInventoryService _service;
    late IOverviewService _overviewService;
    final _mock = Get.find<MockedDatasource>();
    final _builder = Get.find<ProductDataBuilder>();
    final _titles = Get.find<InventoryTestTitles>();

    var _product0, _product1, _newProduct;
    var _products;

    setUpAll(() {
      Get.create(() => InventoryTestBindings());
      var _bindings = Get.find<InventoryTestBindings>();
      _bindings.bindingsBuilder(isWidgetTest: true, isEmptyDb: false);

      _overviewService = Get.find<IOverviewService>();
      _service = Get.find<IInventoryService>();
      _product0 = _mock.products().elementAt(0);
      _product1 = _mock.products().elementAt(1);
      _products = _mock.products();
      _newProduct = _builder.ProductWithId();
    });

    test(_titles.service_get_products, () {
      _service.getProducts().then((productsReturned) {
        expect(productsReturned[0].id, _products.elementAt(0).id);
        expect(productsReturned[0].title, _products.elementAt(0).title);
      });
    });

    test(_titles.service_get_local_products, () {
      _service.getProducts().then((_) {
        var list = _service.getLocalDataInventoryProducts();
        expect(list[0].id, _products.elementAt(0).id);
        expect(list[0].title, _products.elementAt(0).title);
      });
    });

    test(_titles.service_add_product, () {
      _service.addProduct(_product0).then((addedProduct) {
        // In addProduct, never the 'product to be added' has 'id'
        // expect(addedProduct.id, _product0.id);
        expect(addedProduct.title, _product0.title);
        expect(addedProduct.price, _product0.price);
        expect(addedProduct.description, _product0.description);
        expect(addedProduct.imageUrl, _product0.imageUrl);
        expect(addedProduct.isFavorite, _product0.isFavorite);
        expect(addedProduct, isIn(_service.getLocalDataInventoryProducts()));
      });
    });

    test(_titles.service_add_local_product, () {
      var productTest = MockedDatasource().product();

      _service.getProducts().then((_) {
        expect(_service.getLocalDataInventoryProducts().length, 4);

        _service.addLocalDataInventoryProducts(productTest);
        expect(_service.getLocalDataInventoryProducts().length, 5);
        expect(_service.getLocalDataInventoryProducts()[4].title, productTest.title);
      });
    });

    test(_titles.service_get_products_qtde, () {
      _service.getProducts().then((response) {
        expect(response.length, _service.getProductsQtde());
      });
    });

    test(_titles.service_get_products_by_id, () {
      _service.getProducts().then((_) {
        expect(_service.getProductById(_product1.id!),
            isIn(_service.getLocalDataInventoryProducts()));
        expect(_service.getProductById(_product1.id!).title, _product1.title);
      });
    });

    test(_titles.service_get_products_by_id_exc, () {
      _service.getProducts().then((_) {
        expect(
            () => _service.getProductById(_newProduct.id!), throwsA(isA<RangeError>()));
      });
    });

    test(_titles.service_remove_product, () {
      _service.getProducts().then((_) {
        expect(_service.getProductById(_product1.id!),
            isIn(_service.getLocalDataInventoryProducts()));
        _service.deleteProduct(_product1.id!).then((response) {
          expect(response, 200);
        });
      });
    });

    test(_titles.service_update_product, () {
      _overviewService.getProducts().then((_) {
        expect(
          _overviewService.getProductById(_product1.id!),
          isIn(_overviewService.getLocalDataAllProducts()),
        );
      });

      _service.getProducts().then((_) {
        expect(
          _service.getProductById(_product1.id!),
          isIn(_service.getLocalDataInventoryProducts()),
        );

        _service.updateProduct(_product1).then((response) {
          expect(response, 200);
        });
      });
    });

    test(_titles.service_remove_product_transaction, () {
      _service.getProducts().then((_) {
        expect(_service.getProductById(_product1.id!),
            isIn(_service.getLocalDataInventoryProducts()));
        _service.deleteProduct(_product1.id!).then((response) {
          expect(response, 200);
        });
      });
    });

    test(_titles.service_remove_product_exc, () {
      _service.getProducts().then((_) {
        expect(_service.getProductById(_product1.id!),
            isIn(_service.getLocalDataInventoryProducts()));
        expect(() => _service.deleteProduct(_newProduct.id!), throwsA(isA<RangeError>()));
      });
    });

    test(_titles.service_clean_local_data, () {
      _service.getProducts().then((response) {
        expect(_service.getLocalDataInventoryProducts(), isNot(isEmpty));
        _service.clearDataSavingLists();
        expect(_service.getLocalDataInventoryProducts(), isEmpty);
      });
    });
  }
}