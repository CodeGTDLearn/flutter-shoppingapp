import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/inventory/service/i_inventory_service.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:test/test.dart';

import '../../../../mocked_datasource/products_mocked_datasource.dart';
import '../../../../test_utils/data_builders/product_databuilder.dart';
import '../inventory_test_config.dart';
import '../repo/inventory_mocked_repo.dart';
import 'inventory_mocked_service.dart';

class InventoryServiceTest {
  static void unit() {
    IOverviewService _ovService;

    IInventoryService _invService, _invInjectService;

    var _product0 = ProductsMockedDatasource().products().elementAt(0);
    var _product1 = ProductsMockedDatasource().products().elementAt(1);
    var _products = ProductsMockedDatasource().products();
    var _newProduct = ProductDataBuilder().ProductFull();

    setUp(() {
      InventoryTestConfig().bindingsBuilder(InventoryMockedRepo());
      _ovService = Get.find<IOverviewService>();

      _invService = Get.find<IInventoryService>();

      _invInjectService = InventoryInjectMockedService();
    });

    test('Getting Products - ResponseType', () {
      _invService.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('Getting Products', () {
      _invService.getProducts().then((productsReturned) {
        expect(productsReturned[0].id, _products.elementAt(0).id);
        expect(productsReturned[0].title, _products.elementAt(0).title);
      });
    });

    test('Getting LocalDataManagedProducts', () {
      _invService.getProducts().then((_) {
        var list = _invService.getLocalDataManagedProducts();
        expect(list[0].id, _products.elementAt(0).id);
        expect(list[0].title, _products.elementAt(0).title);
      });
    });

    test('Adding Product', () {
      _invService.addProduct(_product0).then((addedProduct) {
        // In addProduct, never the 'product to be added' has 'id'
        // expect(addedProduct.id, _product0.id);
        expect(addedProduct.title, _product0.title);
        expect(addedProduct.price, _product0.price);
        expect(addedProduct.description, _product0.description);
        expect(addedProduct.imageUrl, _product0.imageUrl);
        expect(addedProduct.isFavorite, _product0.isFavorite);
        expect(addedProduct, isIn(_invService.getLocalDataManagedProducts()));
      });
    });

    test('Adding Product in LocalDataManagedProducts', () {
      var productTest = ProductsMockedDatasource().product();

      _invService.getProducts().then((_) {
        expect(_invService.getLocalDataManagedProducts().length, 4);

        _invService.addLocalDataManagedProducts(productTest);
        expect(_invService.getLocalDataManagedProducts().length, 5);
        expect(
            _invService.getLocalDataManagedProducts()[4].title, productTest.title);
      });
    });

    test('Getting ProductsQtde', () {
      _invService.getProducts().then((response) {
        expect(response.length, _invService.managedProductsQtde());
      });
    });

    test('Getting ProductById', () {
      _invService.getProducts().then((_) {
        expect(_invService.getProductById(_product1.id),
            isIn(_invService.getLocalDataManagedProducts()));
        expect(_invService.getProductById(_product1.id).title, _product1.title);
      });
    });

    test('Getting ProductById - Exception', () {
      _invService.getProducts().then((_) {
        expect(() => _invService.getProductById(_newProduct.id),
            throwsA(isA<RangeError>()));
      });
    });

    test('Deleting a Product', () {
      _invService.getProducts().then((_) {
        expect(_invService.getProductById(_product1.id),
            isIn(_invService.getLocalDataManagedProducts()));
        _invService.deleteProduct(_product1.id).then((response) {
          expect(response, 200);
        });
      });
    });

    test('Updating a Product', () {
      _ovService.getProducts().then((_) {
        expect(
          _ovService.getProductById(_product1.id),
          isIn(_ovService.getLocalDataAllProducts()),
        );
      });

      _invService.getProducts().then((_) {
        expect(
          _invService.getProductById(_product1.id),
          isIn(_invService.getLocalDataManagedProducts()),
        );

        _invService.updateProduct(_product1).then((response) {
          expect(response, 200);
        });
      });
    });

    test('Deleting a Product - Optimistic/Rollback', () {
      _invService.getProducts().then((_) {
        expect(_invService.getProductById(_product1.id),
            isIn(_invService.getLocalDataManagedProducts()));
        _invService.deleteProduct(_product1.id).then((response) {
          expect(response, 200);
        });
      });
    });

    test('Deleting a Product(Inject) - Optimistic (Mocked)', () {
      when(_invInjectService.deleteProduct(_newProduct.id))
          .thenAnswer((_) async => Future.value(404));

      when(_invInjectService.getLocalDataManagedProducts()).thenReturn(_products);

      expect(_invInjectService.getLocalDataManagedProducts(), _products);

      _invInjectService.deleteProduct(_newProduct.id).then((response) {
        expect(response, 404);
      });
      //Rollback the localDataManagedProducts 'cause unsuccessful deleteProduct
      expect(_invInjectService.getLocalDataManagedProducts(), _products);
    });

    test('Deleting a Product - Not found - Exception', () {
      _invService.getProducts().then((_) {
        expect(_invService.getProductById(_product1.id),
            isIn(_invService.getLocalDataManagedProducts()));
        expect(() => _invService.deleteProduct(_newProduct.id),
            throwsA(isA<RangeError>()));
      });
    });

    test('Clearing LocalDataManagedProducts', () {
      _invService.getProducts().then((response) {
        expect(_invService.getLocalDataManagedProducts(), isNot(isEmpty));
        _invService.clearDataSavingLists();
        expect(_invService.getLocalDataManagedProducts(), isEmpty);
      });
    });
  }
}
