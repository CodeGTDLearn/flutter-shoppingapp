import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/inventory/repo/i_inventory_repo.dart';

import '../../../../config/bindings/inventory_test_bindings.dart';
import '../../../../mocked_datasource/mocked_datasource.dart';
import 'inventory_mocked_repo.dart';

class InventoryRepoTests {
  static void unit() {
    late IInventoryRepo _repo, _injectRepo;
    var _product0 = MockedDatasource().products().elementAt(0);
    var _product1 = MockedDatasource().products().elementAt(1);

    setUp(() {
      InventoryTestBindings().bindingsBuilderMockedRepo(isUnitTest: true);
      _repo = Get.find<IInventoryRepo>();
      _injectRepo = InventoryInjectMockedRepo();
    });

    test('Checking Test Instances', () {
      expect(_repo, isA<IInventoryRepo>());
      expect(_injectRepo, isA<InventoryInjectMockedRepo>());
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

// test('Deleting a Product(Inject) - status 404', () {
//   when(_injectRepo.deleteProduct(_product0.id!)).thenAnswer((_) async => 404);
//   _injectRepo.deleteProduct(_product0.id!).then((value) => {expect(value, 404)});
// });
// test('Adding a Product(Inject)  - Empty Response', () {
//   when(_injectRepo.getProducts()).thenAnswer((_) async => []);
//   _injectRepo.getProducts().then((value) {
//     expect(value, isEmpty);
//   });
// });

// test('Updating a Product(Inject) - status 500', () {
//   when(_injectRepo.updateProduct(_product0)).thenAnswer((_) async => 500);
//   _injectRepo.updateProduct(_product0).then((value) => {expect(value, 500)});
// });
//
// test('Updating a Product(Inject) - status 404', () {
//   when(_injectRepo.updateProduct(_product0)).thenAnswer((_) async => 404);
//   _injectRepo.updateProduct(_product0).then((value) => {expect(value, 404)});
// });
