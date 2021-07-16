import 'package:get/get.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/overview/components/filter_favorite_enum.dart';
import 'package:shopingapp/app/modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/service/overview_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../config/overview_test_config.dart';
import '../../../mocked_datasource/products_mocked_datasource.dart';

class OverviewControllerTests {
  static void integration() {
    late IOverviewRepo _repo;
    late IOverviewService _service;
    late OverviewController _controller;
    var testConfig = Get.put(OverviewTestConfig());

    setUp(() {
      testConfig.bindingsBuilderMockedRepo(isWidgetTest: true);
      _repo = Get.find<IOverviewRepo>();
      _service = OverviewService(repo: _repo);
      _controller = OverviewController(service: _service);
    });

    test('Checking Instances to be used in the Tests', () {
      expect(_repo, isA<IOverviewRepo>());
      expect(_service, isA<OverviewService>());
      expect(_controller, isA<OverviewController>());
    });

    test('Checking Response Type in GetProducts', () {
      _controller.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('Getting products', () {
      _controller.getProducts().then((value) {
        expect(value[0].title, "Red Shirt");
        expect(value[3].description, 'Prepare any meal you want.');
      });
    });

    test('Updating FilteredProductsObs', () {
      _controller.getProducts().then((value) {
        expect(_controller.getFilteredProductsObs().length, 0);

        var productTest = ProductsMockedDatasource().product();
        expect(_service.getLocalDataAllProducts().length, 4);
        _service.addProductInLocalDataAllProducts(productTest);
        expect(_service.getLocalDataAllProducts().length, 5);

        _controller.updateFilteredProductsObs();
        expect(_controller.getFilteredProductsObs().length, 5);
      });
    });

    test('Deleting Product', () {
      _controller.getProducts().then((value) {
        expect(_service.getLocalDataAllProducts().length, 4);
        _controller.deleteProduct(_service.getLocalDataAllProducts()[0].id);
        expect(_service.getLocalDataAllProducts().length, 3);
      });
    });

    test('Getting the quantity of favorites', () {
      _controller.getProducts().then((value) {
        expect(_controller.getFavoritesQtde(), 1);
      });
    });

    test('Getting the quantity of products', () {
      _controller.getProducts().then((value) {
        expect(_controller.getProductsQtde(), 4);
      });
    });

    test('Getting a product using its ID', () {
      var product = ProductsMockedDatasource().productById("p1");
      _controller.getProducts().then((value) {
        expect(_controller.getProductById("p1").description, product.description);
      });
    });

    test('Getting products by Filters', () {
      _controller.getProducts().then((_) {
        var listAll = _service.getProductsByFilter(EnumFilter.All);
        _controller.getProductsByFilter(EnumFilter.All);
        expect(_controller.getFilteredProductsObs(), listAll);

        var listFav = _service.getProductsByFilter(EnumFilter.Fav);
        _controller.getProductsByFilter(EnumFilter.Fav);
        expect(_controller.getFilteredProductsObs(), listFav);
      });
    });

    test('Toggle FavoriteStatus in one product', () {
      _controller.getProducts().then((_) {
        expect(_controller.getProductById("p3").isFavorite, isTrue);

        _controller.toggleFavoriteStatus("p3").then((sucessOperation) {
          expect(sucessOperation, isTrue);
          expect(_controller.getProductById("p3").isFavorite, isFalse);
          expect(_controller.getFavoriteStatusObs(), isFalse);
        });
      });
    });
  }
}
