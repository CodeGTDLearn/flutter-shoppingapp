import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/inventory/repo/i_inventory_repo.dart';
import 'package:test/test.dart';

import '../../../../mocked_datasource/products_mocked_datasource.dart';
import '../inventory_test_config.dart';
import 'inventory_mocked_repo.dart';

class InventoryRepoTests {
  static void unit() {
    IInventoryRepo _repo, _injectRepo;
    var _product0 = ProductsMockedDatasource().products().elementAt(0);
    var _product1 = ProductsMockedDatasource().products().elementAt(1);

    setUp(() {
      InventoryTestConfig().bindingsBuilder(InventoryMockedRepo());
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

    test('Adding a Product(Inject)  - Empty Response', () {
      when(_injectRepo.getProducts()).thenAnswer((_) async => []);
      _injectRepo.getProducts().then((value) {
        expect(value, isEmpty);
      });
    });

    test('Adding a Product(Inject)  - Null Response', () {
      when(_injectRepo.getProducts()).thenAnswer((_) async => null);
      _injectRepo.getProducts().then((value) {
        expect(value, isNull);
      });
    });

    test('Updating a Product - status 200', () {
      _repo.updateProduct(_product0).then((value) {
        expect(value, 200);
      });
    });

    test('Updating a Product(Inject) - status 400', () {
      when(_injectRepo.updateProduct(_product0)).thenAnswer((_) async => 400);

      _injectRepo.updateProduct(_product0).then((value) => {expect(value, 400)});
    });

    test('Updating a Product(Inject) - status 404', () {
      when(_injectRepo.updateProduct(_product0)).thenAnswer((_) async => 404);

      _injectRepo.updateProduct(_product0).then((value) => {expect(value, 404)});
    });

    test('Deleting a Product - status 200', () {
      _repo.getProducts().then((response) {
        expect(response, isA<List<Product>>());
        expect(response[0].id, _product0.id);
        expect(response[0].title, _product0.title);

        _repo.deleteProduct(_product0.id).then((value) {
          expect(value, 200);
          expect(response[0].id, isNot(isIn(response)));
        });
      });
    });

    test('Deleting a Product(Inject) - status 404', () {
      when(_injectRepo.deleteProduct(_product0.id)).thenAnswer((_) async => 404);

      _injectRepo.deleteProduct(_product0.id).then((value) => {expect(value, 404)});
    });
  }
}
