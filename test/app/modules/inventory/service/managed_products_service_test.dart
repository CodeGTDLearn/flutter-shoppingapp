import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/inventory/repo/i_inventory_repo.dart';
import 'package:shopingapp/app/modules/inventory/service/i_inventory_service.dart';
import 'package:shopingapp/app/modules/inventory/service/inventory_service.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/service/overview_service.dart';
import 'package:test/test.dart';

import '../../../../test_utils/data_builders/product_databuilder.dart';
import '../../../../test_utils/mocked_datasource/products_mocked_datasource.dart';
import '../../../../test_utils/test_utils.dart';
import '../../overview/repo/overview_repo_mocks.dart';
import '../repo/managed_products_repo_mocks.dart';
import 'managed_products_service_mock.dart';

class ManagedProductsServiceTest {
  static void unit() {
    IInventoryService _mPService, _injectMockService;
    IInventoryRepo _mockRepoManagedProducts;
    IOverviewRepo _mockRepoOverviewProducts;
    IOverviewService _ovService;
    var _product0 = ProductsMockedDatasource().products().elementAt(0);
    var _product1 = ProductsMockedDatasource().products().elementAt(1);
    var _products = ProductsMockedDatasource().products();
    var _newProduct = ProductDataBuilder().ProductFull();

    setUp(() {
      _mockRepoOverviewProducts = OverviewMockRepo();
      _ovService = OverviewService(repo: _mockRepoOverviewProducts);

      _mockRepoManagedProducts = ManagedProductsMockRepo();
      _mPService = InventoryService(
        repo: _mockRepoManagedProducts,
        overviewService: _ovService,
      );

      _injectMockService = ManagedProductsInjectMockService();
    });

    tearDown(TestMethods.globalTearDown);

    test('Checking Test Instances', () {
      expect(_mockRepoManagedProducts, isA<ManagedProductsMockRepo>());
      expect(_mPService, isA<InventoryService>());
      expect(_injectMockService, isA<ManagedProductsInjectMockService>());
      expect(_product0, isA<Product>());
      expect(_product1, isA<Product>());
    });

    test('Getting Products - ResponseType', () {
      _mPService.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('Getting Products', () {
      _mPService.getProducts().then((productsReturned) {
        expect(productsReturned[0].id, _products.elementAt(0).id);
        expect(productsReturned[0].title, _products.elementAt(0).title);
      });
    });

    test('Getting LocalDataManagedProducts', () {
      _mPService.getProducts().then((_) {
        var list = _mPService.getLocalDataManagedProducts();
        expect(list[0].id, _products.elementAt(0).id);
        expect(list[0].title, _products.elementAt(0).title);
      });
    });

    test('Adding Product', () {
      _mPService.addProduct(_product0).then((addedProduct) {
        // In addProduct, never the 'product to be added' has 'id'
        // expect(addedProduct.id, _product0.id);
        expect(addedProduct.title, _product0.title);
        expect(addedProduct.price, _product0.price);
        expect(addedProduct.description, _product0.description);
        expect(addedProduct.imageUrl, _product0.imageUrl);
        expect(addedProduct.isFavorite, _product0.isFavorite);
        expect(addedProduct, isIn(_mPService.getLocalDataManagedProducts()));
      });
    });

    test('Adding Product in LocalDataManagedProducts', () {
      var productTest = ProductsMockedDatasource().product();

      _mPService.getProducts().then((_) {
        expect(_mPService.getLocalDataManagedProducts().length, 4);

        _mPService.addLocalDataManagedProducts(productTest);
        expect(_mPService.getLocalDataManagedProducts().length, 5);
        expect(_mPService.getLocalDataManagedProducts()[4].title,
            productTest.title);
      });
    });

    test('Getting ProductsQtde', () {
      _mPService.getProducts().then((response) {
        expect(response.length, _mPService.managedProductsQtde());
      });
    });

    test('Getting ProductById', () {
      _mPService.getProducts().then((_) {
        expect(_mPService.getProductById(_product1.id),
            isIn(_mPService.getLocalDataManagedProducts()));
        expect(_mPService.getProductById(_product1.id).title, _product1.title);
      });
    });

    test('Getting ProductById - Exception', () {
      _mPService.getProducts().then((_) {
        expect(() => _mPService.getProductById(_newProduct.id),
            throwsA(isA<RangeError>()));
      });
    });

    test('Deleting a Product', () {
      _mPService.getProducts().then((_) {
        expect(_mPService.getProductById(_product1.id),
            isIn(_mPService.getLocalDataManagedProducts()));
        _mPService.deleteProduct(_product1.id).then((response) {
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

      _mPService.getProducts().then((_) {
        expect(
          _mPService.getProductById(_product1.id),
          isIn(_mPService.getLocalDataManagedProducts()),
        );

        _mPService.updateProduct(_product1).then((response) {
          expect(response, 200);
        });
      });
    });

    test('Deleting a Product - Optimistic/Rollback', () {
      _mPService.getProducts().then((_) {
        expect(_mPService.getProductById(_product1.id),
            isIn(_mPService.getLocalDataManagedProducts()));
        _mPService.deleteProduct(_product1.id).then((response) {
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
      _mPService.getProducts().then((_) {
        expect(_mPService.getProductById(_product1.id),
            isIn(_mPService.getLocalDataManagedProducts()));
        expect(() => _mPService.deleteProduct(_newProduct.id),
            throwsA(isA<RangeError>()));
      });
    });

    test('Clearing LocalDataManagedProducts', () {
      _mPService.getProducts().then((response) {
        expect(_mPService.getLocalDataManagedProducts(), isNot(isEmpty));
        _mPService.clearDataSavingLists();
        expect(_mPService.getLocalDataManagedProducts(), isEmpty);
      });
    });
  }
}
