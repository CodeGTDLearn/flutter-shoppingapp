import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/pages_modules/overview/service/overview_service.dart';
import 'package:test/test.dart';

import '../../../../mock_data_source/mocked_data_source.dart';
import '../repo/overview_repo_mocks.dart';
import 'overview_service_mocks.dart';

void main() {
  IOverviewService _service, _serviceMockWhen;
  IOverviewRepo _repo;

  setUp(() {
    _repo = DataMockRepo();
    _service = OverviewService(repo: _repo);
    _serviceMockWhen = WhenMockService();
  });

  group('Overview | Service(DataMock)', () {
    test('Checking Instances', () {
      expect(_service, isA<OverviewService>());
    });

    test('Checking Response Type', () {
      _service.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('localDataAllProducts', () {
      _service.getProducts().then((_) {
        var list = _service.localDataAllProducts;
        expect(list[0].title, "Red Shirt");
        expect(list[3].description, 'Prepare any meal you want.');
      });
    });

    test('localDataFavoritesProducts', () {
      _service.getProducts().then((_) {
        var list = _service.localDataFavoritesProducts;
        expect(list[0].isFavorite, true);
        expect(list[0].title, "Yellow Scarf");
        expect(list[0].price, 19.99);
      });
    });

    test('getFavoritesQtde', () {
      _service.getProducts().then((_) {
        expect(_service.getFavoritesQtde(), 1);
      });
    });

    test('getProductById', () {
      _service.getProducts().then((_) {
        var list = _service.localDataAllProducts;
        expect(
            _service.getProductById("p1").description, list[0].description);
      });
    });

    test('getProductsQtde', () {
      _service.getProducts().then((_) {
        expect(_service.getProductsQtde(), 4);
      });
    });

    test('getProductsByFilter', () {
      _service.getProducts().then((_) {
        var listAll = _service.getProductsByFilter(EnumFilter.All);
        var listFav = _service.getProductsByFilter(EnumFilter.Fav);
        expect(listAll.length, 4);
        expect(listFav.length, 1);
      });
    });

    test('getProducts', () {
      _service.getProducts().then((FetchedListd) {
        // var list = _service.localDataAllProducts;
        expect(FetchedListd[0].title, "Red Shirt");
        expect(FetchedListd[3].description, 'Prepare any meal you want.');
      });
    });

    test('toggleFavoriteStatus', () {
      _service.getProducts().then((_) {
        expect(_service.getProductById("p3").isFavorite, true);

        _service.toggleFavoriteStatus("p3").then((value) {
          expect(value, false);
        });

      });
    });

    test('Checking Instances - When', () {
      expect(_serviceMockWhen, isA<WhenMockService>());
    });

    test('getProducts - When', () {
      // @formatter:off
      when(_serviceMockWhen.getProducts())
          .thenAnswer((_) async => Future.value(MockedDataSource().products()));

      _serviceMockWhen.getProducts().then((value) {
        expect(value[0].title, "Red Shirt");
        expect(value[3].description, 'Prepare any meal you want.');
      });
      // @formatter:on
    });

    test('toggleFavoriteStatus - When', () {
      when(_serviceMockWhen.toggleFavoriteStatus("p1"))
          .thenAnswer((_) async => true);

      _serviceMockWhen
          .toggleFavoriteStatus("p1")
          .then((value) => expect(value, true));
    });
  });
}

