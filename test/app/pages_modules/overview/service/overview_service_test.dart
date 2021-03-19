import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/pages_modules/overview/service/overview_service.dart';
import 'package:test/test.dart';

import '../../../../test_utils/data_builders/product_databuilder.dart';
import '../../../../test_utils/mocked_data/mocked_products_data.dart';
import '../repo/overview_repo_mocks.dart';
import 'overview_service_mocks.dart';

class OverviewServiceTest {
  static void unit() {
    IOverviewService _service, _injectMockService;
    IOverviewRepo _mockRepo;

    setUp(() {
      _mockRepo = OverviewMockRepo();
      _service = OverviewService(repo: _mockRepo);
      _injectMockService = OverviewInjectMockService();
    });

    // group('Service | Mocked-Repo', () {
    test('Checking Instances to be used in the Tests', () {
      expect(_service, isA<OverviewService>());
      expect(_mockRepo, isA<OverviewMockRepo>());
    });

    test('Checking Response Type in GetProducts', () {
      _service.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('Checking localDataAllProducts loading', () {
      _service.getProducts().then((_) {
        var list = _service.getLocalDataAllProducts;
        expect(list[0].title, "Red Shirt");
        expect(list[3].description, 'Prepare any meal you want.');
      });
    });

    test('Checking localDataFavoritesProducts loading', () {
      _service.getProducts().then((_) {
        var list = _service.localDataFavoritesProducts;
        expect(list[0].isFavorite, isTrue);
        expect(list[0].title, "Yellow Scarf");
        expect(list[0].price, 19.99);
      });
    });

    test('Adding Product in LocalDataAllProducts', () {
        var productTest = ProductsMockedData().product();

      _service.getProducts().then((_) {
        expect(_service.getLocalDataAllProducts.length, 4);

        _service.addProductInLocalDataAllProducts(productTest);
        expect(_service.getLocalDataAllProducts.length, 5);
        expect(_service.getLocalDataAllProducts[4].title, productTest.title);
      });
    });

    test('Getting products', () {
      _service.getProducts().then((FetchedList) {
        // var list = _service.localDataAllProducts;
        expect(FetchedList[0].title, "Red Shirt");
        expect(FetchedList[3].description, 'Prepare any meal you want.');
      });
    });

    test('Getting a product (unknown ID) - Exception', () {
      _service.getProducts().then((_) {
        expect(() => _service.getProductById("p10"),
            throwsA(const TypeMatcher<RangeError>()));
      });
    });

    test('Toggle FavoriteStatus in one product', () {
      _service.getProducts().then((_) {
        expect(_service.getProductById("p3").isFavorite, isTrue);

        _service.toggleFavoriteStatus("p3").then((toggleReturn) {
          expect(toggleReturn, isFalse);
          expect(_service.getProductById("p3").isFavorite, isFalse);
        });
      });
    });

    test('Getting the quantity of favorites', () {
      _service.getProducts().then((_) {
        expect(_service.getFavoritesQtde(), 1);
      });
    });

    test('Getting a product using its ID', () {
      _service.getProducts().then((_) {
        var list = _service.getLocalDataAllProducts;
        expect(_service.getProductById("p1").description, list[0].description);
      });
    });

    test('Getting the quantity of products', () {
      _service.getProducts().then((_) {
        expect(_service.getProductsQtde(), 4);
      });
    });

    test('Getting products by Filters', () {
      _service.getProducts().then((_) {
        var listAll = _service.getProductsByFilter(EnumFilter.All);
        var listFav = _service.getProductsByFilter(EnumFilter.Fav);
        expect(listAll.length, 4);
        expect(listFav.length, 1);
      });
    });

    test('Clearing DataSavingLists', () {
      _service.getProducts().then((_) {
        var listAll = _service.getProductsByFilter(EnumFilter.All);
        var listFav = _service.getProductsByFilter(EnumFilter.Fav);
        expect(listAll.length, 4);
        expect(listFav.length, 1);
        _service.clearDataSavingLists();
        listAll = _service.getProductsByFilter(EnumFilter.All);
        listFav = _service.getProductsByFilter(EnumFilter.Fav);
        expect(listAll.length, 0);
        expect(listFav.length, 0);
      });
    });
    // });
    // group('Injectable-Mocked-Service', () {
    test('Checking Instances to be used in the Tests', () {
      expect(_injectMockService, isA<OverviewInjectMockService>());
    });

    test('Getting products - Fail hence Empty', () {
      // @formatter:off
      when(_injectMockService.getProducts())
          .thenAnswer((_) async => Future
          .value(ProductsMockedData()
          .productsEmpty()));

      _injectMockService.getProducts().then((value) {
        expect(value, List.empty());
      });
      // @formatter:on
    });

    test('Toggle FavoriteStatus in a product - Fail 404', () {
      //INJECTABLE FOR SIMPLE-RETURNS
      when(_injectMockService.getProductById("p3"))
          .thenReturn(ProductDataBuilder().ProductFull());

      //INJECTABLE FOR FUTURES-RETURNS
      when(_injectMockService.toggleFavoriteStatus("p3"))
          .thenAnswer((_) async => Future.value(true));

      var previousToggleStatus =
          _injectMockService.getProductById("p3").isFavorite;

      _injectMockService.toggleFavoriteStatus("p3").then((value) {
        expect(true, previousToggleStatus);
      });
    });
    // });
  }
}