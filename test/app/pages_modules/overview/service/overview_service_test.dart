import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';
import 'package:test/test.dart';

import '../utils/mocked_data_source.dart';
import 'overview_service_mocks.dart';

void main() {
  IOverviewService _dataMockService, _whenMockService;

  setUp(() {
    _dataMockService = DataMockService();
    _whenMockService = WhenMockService();
  });

  group('Overview | Service: DataMock', () {
    test('Checking Instances', () {
      expect(_dataMockService, isA<DataMockService>());
    });

    test('Checking Response Type', () {
      _dataMockService.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('dataSavingAllProducts', () {
      var list = _dataMockService.localDataAllProducts;
      expect(list[0].title, "Red Shirt");
      expect(list[3].description, 'Prepare any meal you want.');
    });

    test('dataSavingFavoritesProducts', () {
      var list = _dataMockService.localDataFavoritesProducts;
      expect(list[0].isFavorite, true);
    });

    test('getFavoritesQtde', () {
      expect(_dataMockService.getFavoritesQtde(), 1);
    });

    test('getProductById', () {
      var list = _dataMockService.localDataAllProducts;
      expect(_dataMockService.getProductById("p1").description,
          list[0].description);
    });

    test('getProductsQtde', () {
      expect(_dataMockService.getProductsQtde(), 4);
    });

    test('getProductsByFilter', () {
      var listAll = _dataMockService.getProductsByFilter(EnumFilter.All);
      var listFav = _dataMockService.getProductsByFilter(EnumFilter.Fav);
      expect(listAll.length, 4);
      expect(listFav.length, 1);
    });
  });

  group('Overview | Service: WhenMock', () {
    test('Checking Instances', () {
      expect(_whenMockService, isA<WhenMockService>());
    });

    test('getProducts', () {
      // @formatter:off
      when(_whenMockService.getProducts())
          .thenAnswer((_) async => Future.value(MockedDataSource().products()));

      _whenMockService.getProducts().then((value) {
        expect(value[0].title, "Red Shirt");
        expect(value[3].description, 'Prepare any meal you want.');
      });
      // @formatter:on
    });

    test('toggleFavoriteStatus', () {
      when(_whenMockService.toggleFavoriteStatus("p1"))
          .thenAnswer((_) async => true);

      _whenMockService
          .toggleFavoriteStatus("p1")
          .then((value) => expect(value, true));
    });
  });
}
// test('Testind Bindings - DI', () {
//   expect(Get.isPrepared<IOverviewService>(), false);
//   expect(Get.isPrepared<IOverviewRepo>(), false);
//   binding.builder();
//
//   /// test you Binding class with BindingsBuilder
//
//   expect(Get.isPrepared<IOverviewService>(), true);
//   expect(Get.isPrepared<IOverviewRepo>(), true);
//   Get.reset();
// });

// final binding = BindingsBuilder(() {
//   Get.lazyPut<IOverviewRepo>(() => OverviewFirebaseRepo());
//   Get.lazyPut<IOverviewService>(() => OverviewService());
// });
