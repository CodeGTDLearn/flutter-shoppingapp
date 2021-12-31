import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';
import 'package:shopingapp/app/modules/overview/components/overview_appbar/filter_options.dart';
import 'package:shopingapp/app/modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/service/overview_service.dart';

import '../../../datasource/mocked_datasource.dart';
import '../../core/bindings/overview_test_bindings.dart';

class OverviewControllerTests {
  void integration() {
    late IOverviewRepo _repo;
    late IOverviewService _service;
    late OverviewController _controller;
    var testConfig = Get.put(OverviewTestBindings());

    setUp(() {
      testConfig.bindingsBuilder(isWidgetTest: true, isEmptyDb: false);
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
        expect(_controller.gridItemsObs.toList().length, 0);

        var productTest = MockedDatasource().product();
        expect(_service.getLocalDataAllProducts().length, 4);
        _service.addProductInLocalDataAllProducts(productTest);
        expect(_service.getLocalDataAllProducts().length, 5);

        _controller.updateFilteredProductsObs();
        expect(_controller.gridItemsObs.toList().length, 5);
      });
    });

    test('Deleting Product', () {
      _controller.getProducts().then((value) {
        expect(_service.getLocalDataAllProducts().length, 4);
        _controller.deleteProduct(_service.getLocalDataAllProducts()[0].id!);
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
      var product = MockedDatasource().productById("p1");
      _controller.getProducts().then((value) {
        expect(_controller.getProductById("p1").description, product.description);
      });
    });

    test('Getting products by Filters', () {
      _controller.getProducts().then((_) {
        var listAll = _service.setProductsByFilter(FilterOptions.All);
        _controller.applyPopupFilter(FilterOptions.All);
        expect(_controller.gridItemsObs.toList(), listAll);

        var listFav = _service.setProductsByFilter(FilterOptions.Fav);
        _controller.applyPopupFilter(FilterOptions.Fav);
        expect(_controller.gridItemsObs.toList(), listFav);
      });
    });

    test('Toggle FavoriteStatus in one product', () {
      _controller.getProducts().then((_) {
        expect(_controller.getProductById("p3").isFavorite, isTrue);

        _controller.toggleFavoriteStatus("p3").then((sucessOperation) {
          expect(sucessOperation, isTrue);
          expect(_controller.getProductById("p3").isFavorite, isFalse);
          expect(_controller.favoriteStatusObs.value, isFalse);
        });
      });
    });
  }
}