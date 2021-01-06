import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/managed_products/repo/i_managed_products_repo.dart';
import 'package:shopingapp/app/pages_modules/managed_products/service/i_managed_products_service.dart';
import 'package:shopingapp/app/pages_modules/managed_products/service/managed_products_service.dart';
import 'package:test/test.dart';

import '../../../../test_utils/custom_test_methods.dart';
import '../../../../test_utils/data_builders/product_databuilder.dart';
import '../../../../test_utils/mocked_data_source/products_mocked_data.dart';
import '../repo/managed_products_repo_mocks.dart';
import 'managed_products_service_mock.dart';

class ManagedProductsServiceTest {
  static void unit() {
    IManagedProductsService _service, _injectMockService;
    IManagedProductsRepo _mockRepo;
    var _product0 = ProductsMockedData().products().elementAt(0);
    var _product1 = ProductsMockedData().products().elementAt(1);
    var _products = ProductsMockedData().products();
    var _newProduct = ProductDataBuilder().ProductFull();

    setUp(() {
      _mockRepo = ManagedProductsMockRepo();
      _service = ManagedProductsService(repo: _mockRepo);
      _injectMockService = ManagedProductsInjectMockService();
    });

    tearDown(CustomTestMethods.globalTearDown);

    test('Checking Test Instances', () {
      expect(_mockRepo, isA<ManagedProductsMockRepo>());
      expect(_service, isA<ManagedProductsService>());
      expect(_injectMockService, isA<ManagedProductsInjectMockService>());
      expect(_product0, isA<Product>());
      expect(_product1, isA<Product>());
    });

    test('Getting Products - ResponseType', () {
      _service.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('Getting Products', () {
      _service.getProducts().then((productsReturned) {
        expect(productsReturned[0].id, _products.elementAt(0).id);
        expect(productsReturned[0].title, _products.elementAt(0).title);
      });
    });

    test('Getting LocalDataManagedProducts', () {
      _service.getProducts().then((_) {
        var list = _service.getLocalDataManagedProducts();
        expect(list[0].id, _products.elementAt(0).id);
        expect(list[0].title, _products.elementAt(0).title);
      });
    });

    test('Adding Product', () {
      _service.addProduct(_product0).then((addedProduct) {
        // In addProduct, never the 'product to be added' has 'id'
        // expect(addedProduct.id, _product0.id);
        expect(addedProduct.title, _product0.title);
        expect(addedProduct.price, _product0.price);
        expect(addedProduct.description, _product0.description);
        expect(addedProduct.imageUrl, _product0.imageUrl);
        expect(addedProduct.isFavorite, _product0.isFavorite);
        expect(addedProduct, isIn(_service.getLocalDataManagedProducts()));
      });
    });

    test('Getting ProductsQtde', () {
      _service.getProducts().then((response) {
        expect(response.length, _service.managedProductsQtde());
      });
    });

    test('Getting ProductById', () {
      _service.getProducts().then((_) {
        expect(_service.getProductById(_product1.id),
            isIn(_service.getLocalDataManagedProducts()));
        expect(_service.getProductById(_product1.id).title, _product1.title);
      });
    });

    test('Getting ProductById - Exception', () {
      _service.getProducts().then((_) {
        expect(() => _service.getProductById(_newProduct.id),
            throwsA(isA<RangeError>()));
      });
    });

    test('Deleting a Product', () {
      _service.getProducts().then((_) {
        expect(_service.getProductById(_product1.id),
            isIn(_service.getLocalDataManagedProducts()));
        _service.deleteProduct(_product1.id).then((response) {
          expect(response, 200);
        });
      });
    });

    test('Updating a Product', () {
      _service.getProducts().then((_) {
        expect(_service.getProductById(_product1.id),
            isIn(_service.getLocalDataManagedProducts()));

        _service.updateProduct(_product1).then((response) {
          expect(response, 200);
        });
      });
    });

    test('Deleting a Product - Optimistic/Rollback', () {
      _service.getProducts().then((_) {
        expect(_service.getProductById(_product1.id),
            isIn(_service.getLocalDataManagedProducts()));
        _service.deleteProduct(_product1.id).then((response) {
          expect(response, 200);
        });
      });
    });

    test('Deleting a Product(Inject) - Optimistic (Mocked)', () {
      when(_injectMockService.deleteProduct(_newProduct.id))
          .thenAnswer((_) async => Future.value(404));

      when(_injectMockService.getLocalDataManagedProducts())
          .thenReturn(_products);

      expect(_injectMockService.getLocalDataManagedProducts(), _products);

      _injectMockService.deleteProduct(_newProduct.id).then((response) {
        expect(response, 404);
      });
      //Rollback the localDataManagedProducts 'cause unsuccessful deleteProduct
      expect(_injectMockService.getLocalDataManagedProducts(), _products);
    });

    test('Deleting a Product - Not found - Exception', () {
      _service.getProducts().then((_) {
        expect(_service.getProductById(_product1.id),
            isIn(_service.getLocalDataManagedProducts()));
        expect(() => _service.deleteProduct(_newProduct.id),
            throwsA(isA<RangeError>()));
      });
    });

    test('Clearing LocalDataManagedProducts', () {
      _service.getProducts().then((response) {
        expect(_service.getLocalDataManagedProducts(), isNot(isEmpty));
        _service.clearDataSavingLists();
        expect(_service.getLocalDataManagedProducts(), isEmpty);
      });
    });
  }
}
