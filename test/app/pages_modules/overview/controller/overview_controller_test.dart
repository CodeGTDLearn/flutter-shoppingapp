import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/i_overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/pages_modules/overview/service/overview_service.dart';
import 'package:test/test.dart';

import '../../../../test_utils/mocked_data_source/products_mocked_data.dart';
import '../repo/overview_repo_mocks.dart';
import 'overview_controller_mocks.dart';

// void main() {
class OverviewControllerTest {
  static void integration() {
    IOverviewController _controller, _injectMockController;
    IOverviewService _service;
    IOverviewRepo _mockRepo;

    setUp(() {
      _mockRepo = OverviewMockRepo();
      _service = OverviewService(repo: _mockRepo);
      _controller = OverviewController(service: _service);
      _injectMockController = OverviewInjectMockController();
    });

    // group(' Controller | Service | Mocked-Repo', () {
    test('Checking Instances to be used in the Tests', () {
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
        print("${value.length}");
        expect(value[0].title, "Red Shirt");
        expect(value[3].description, 'Prepare any meal you want.');
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
      var product = ProductsMockedData().productById("p1");
      _controller.getProducts().then((value) {
        expect(
            _controller.getProductById("p1").description, product.description);
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

    test('Checking Instances to be used in the Tests', () {
      expect(_injectMockController, isA<OverviewInjectMockController>());
    });

    test('Getting products - Fail hence Empty', () {
      // @formatter:off
      when(_injectMockController.getProducts())
          .thenAnswer((_) async => Future
          .value(ProductsMockedData()
          .productsEmpty()));

      _injectMockController.getProducts()
          .then((value) {
            expect(value, List.empty());
          });
      // @formatter:on
    });

    test('Toggle FavoriteStatus in a product - Fail 404', () {
      //INJECTABLE FOR FUTURES-RETURNS
      when(_injectMockController.toggleFavoriteStatus("p3"))
          .thenAnswer((_) async => Future.value(false));

      _injectMockController.toggleFavoriteStatus("p3")
          .then((sucessOperation) {
        expect(sucessOperation, isFalse);
      });
    });
    // });
  }
}
