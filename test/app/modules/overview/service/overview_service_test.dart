import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';
import 'package:shopingapp/app/modules/overview/components/filter_favorite_enum.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/service/overview_service.dart';

import '../../../../config/bindings/overview_test_bindings.dart';
import '../../../../datasource/mocked_datasource.dart';
import 'overview_mocked_service.dart';

class OverviewServiceTests {
  void unit() {
    late IOverviewRepo _repo;
    late IOverviewService _service, _injectService;
    var testConfig = Get.put(OverviewTestBindings());

    setUp(() {
      testConfig.bindingsBuilder(isWidgetTest: true);
      _repo = Get.find<IOverviewRepo>();
      _service = OverviewService(repo: _repo);
      _injectService = OverviewInjectMockedService();
    });

    test('Checking Instances to be used in the Tests', () {
      expect(_repo, isA<IOverviewRepo>());
      expect(_service, isA<IOverviewService>());
      expect(_injectService, isA<OverviewInjectMockedService>());
    });

    test('Checking Response Type in GetProducts', () {
      _service.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('Checking localDataAllProducts loading', () {
      _service.getProducts().then((_) {
        var list = _service.getLocalDataAllProducts();
        expect(list[0].title, "Red Shirt");
        expect(list[3].description, 'Prepare any meal you want.');
      });
    });

    test('Checking localDataFavoritesProducts loading', () {
      _service.getProducts().then((_) {
        var list = _service.getLocalDataFavoritesProducts();
        expect(list[0].isFavorite, isTrue);
        expect(list[0].title, "Yellow Scarf");
        expect(list[0].price, 19.99);
      });
    });

    test('Adding Product in LocalDataAllProducts', () {
      var productTest = MockedDatasource().product();

      _service.getProducts().then((_) {
        expect(_service.getLocalDataAllProducts().length, 4);

        _service.addProductInLocalDataAllProducts(productTest);
        expect(_service.getLocalDataAllProducts().length, 5);
        expect(_service.getLocalDataAllProducts()[4].title, productTest.title);
      });
    });

    test('Deleting Product', () {
      _service.getProducts().then((value) {
        expect(_service.getLocalDataAllProducts().length, 4);
        _service.deleteProductInLocalDataLists(_service.getLocalDataAllProducts()[0].id!);
        expect(_service.getLocalDataAllProducts().length, 3);
      });
    });

    test('Getting products', () {
      _service.getProducts().then((FetchedList) {
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
        expect(_service.getProductById("p1").description, list()[0].description);
      });
    });

    test('Getting the quantity of products', () {
      _service.getProducts().then((_) {
        expect(_service.getProductsQtde(), 4);
      });
    });

    test('Getting products by Filters', () {
      _service.getProducts().then((_) {
        var listAll = _service.setProductsByFilter(EnumFilter.All);
        var listFav = _service.setProductsByFilter(EnumFilter.Fav);
        expect(listAll.length, 4);
        expect(listFav.length, 1);
      });
    });

    test('Clearing DataSavingLists', () {
      _service.getProducts().then((_) {
        var listAll = _service.setProductsByFilter(EnumFilter.All);
        var listFav = _service.setProductsByFilter(EnumFilter.Fav);
        expect(listAll.length, 4);
        expect(listFav.length, 1);
        _service.clearDataSavingLists();
        listAll = _service.setProductsByFilter(EnumFilter.All);
        listFav = _service.setProductsByFilter(EnumFilter.Fav);
        expect(listAll.length, 0);
        expect(listFav.length, 0);
      });
    });
  }
}
