import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';
import 'package:shopingapp/app/modules/inventory/repo/i_inventory_repo.dart';

import '../../../../config/titles/inventory_test_titles.dart';
import '../../../../datasource/mocked_datasource.dart';
import '../../../core/bindings/inventory_test_bindings.dart';

class InventoryRepoTests {
  void unit() {
    late IInventoryRepo _repo;
    var _product0, _product1;
    final _mock = Get.find<MockedDatasource>();
    final _titles = Get.put(InventoryTestTitles());

    setUpAll(() {
      Get.create(() => InventoryTestBindings());
      var _bindings = Get.find<InventoryTestBindings>();
      _bindings.bindingsBuilder(isWidgetTest: true, isEmptyDb: false);

      _repo = Get.find<IInventoryRepo>();
      _product0 = _mock.products().elementAt(0);
      _product1 = _mock.products().elementAt(1);
    });

    test(_titles.repo_get_products, () {
      _repo.getProducts().then((response) {
        expect(response, isA<List<Product>>());
        expect(response[0].id, _product0.id);
        expect(response[0].title, _product0.title);
        expect(response[1].id, _product1.id);
        expect(response[1].title, _product1.title);
      });
    });

    test(_titles.repo_get_products_auth_error, () {
      _repo.getProducts().catchError((onError) {
        if (onError.toString().isNotEmpty) {
          fail("Error: Aut");
        }
      });
    });

    test(_titles.repo_add_product, () {
      _repo.addProduct(_product0).then((addedProduct) {
        // In addProduct, never the 'product to be added' has 'id'
        // expect(addedProduct.id, _product0.id);
        expect(addedProduct.title, _product0.title);
        expect(addedProduct.price, _product0.price);
        expect(addedProduct.description, _product0.description);
        expect(addedProduct.imageUrl, _product0.imageUrl);
        expect(addedProduct.isFavorite, _product0.isFavorite);
      });
    });

    test(_titles.repo_update_product, () {
      _repo.updateProduct(_product0).then((value) {
        expect(value, 200);
      });
    });

    test(_titles.repo_remove_product, () {
      _repo.getProducts().then((response) {
        expect(response, isA<List<Product>>());
        expect(response[0].id, _product0.id);
        expect(response[0].title, _product0.title);

        _repo.deleteProduct(_product0.id!).then((value) {
          expect(value, 200);
          expect(response[0].id, isNot(isIn(response)));
        });
      });
    });
  }
}