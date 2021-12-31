import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';
import 'package:shopingapp/app/modules/inventory/repo/i_inventory_repo.dart';

import '../../../../datasource/mocked_datasource.dart';
import '../../../core/bindings/inventory_test_bindings.dart';
import 'inventory_mocked_repo_inject.dart';

class InventoryRepoTests {
  void unit() {
    late IInventoryRepo _repo, _injectRepo;
    var _product0 = MockedDatasource().products().elementAt(0);
    var _product1 = MockedDatasource().products().elementAt(1);

    setUp(() {
      InventoryTestBindings().bindingsBuilder(isWidgetTest: true, isEmptyDb: false);
      _repo = Get.find<IInventoryRepo>();
      _injectRepo = InventoryMockedRepoInject();
    });

    test('Checking Test Instances', () {
      expect(_repo, isA<IInventoryRepo>());
      expect(_injectRepo, isA<InventoryMockedRepoInject>());
      expect(_product0, isA<Product>());
      expect(_product1, isA<Product>());
    });

    test('Getting Products', () {
      _repo.getProducts().then((response) {
        expect(response, isA<List<Product>>());
        expect(response[0].id, _product0.id);
        expect(response[0].title, _product0.title);
        expect(response[1].id, _product1.id);
        expect(response[1].title, _product1.title);
      });
    });

    //todo: erro authentication to be done
    test('Getting products - Error authentication', () {
      _repo.getProducts().catchError((onError) {
        if (onError.toString().isNotEmpty) {
          fail("Error: Aut");
        }
      });
    });

    test('Adding a Product', () {
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

    test('Updating a Product - status 200', () {
      _repo.updateProduct(_product0).then((value) {
        expect(value, 200);
      });
    });

    test('Deleting a Product - status 200', () {
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