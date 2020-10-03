import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';
import 'package:shopingapp/app/pages_modules/overview/core/overview_bindings.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/overview_firebase_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/pages_modules/overview/service/overview_service.dart';
import 'package:test/test.dart';

import '../repo/overview_repo_mocks.dart';
import 'overview_service_mocks.dart';

void main() {
  IOverviewService _dataMockService, _mockService;
  IOverviewRepo _mockRepo;

  setUp(() {
    OverviewBindings().dependencies();
    _dataMockService = DataMockService();
    _mockService = MockService();
  });

  group('Overview | Service', () {
    test('checking Instantiations', () {
      expect(_dataMockService, isA<DataMockService>());
      expect(_mockService, isA<MockService>());
    });

    test('checking Response Type', () {
      _dataMockService.getProducts().then((value) {
        expect(value, isA<List<Product>>());
      });
    });

    test('dataSavingAllProducts', () {
      var list = _dataMockService.dataSavingAllProducts;
      expect(list[0].title, "Red Shirt");
      expect(list[3].description, 'Prepare any meal you want.');
    });

    test('dataSavingFavoritesProducts', () {
      var list = _dataMockService.dataSavingFavoritesProducts;
      expect(list[0].isFavorite, true);
    });

    test('getFavoritesQtde', () {
      expect(_dataMockService.getFavoritesQtde(), 1);
    });

    test('getProductById', () {
      var list = _dataMockService.dataSavingAllProducts;
      expect(_dataMockService.getProductById("p1").description,
          list[0].description);
    });

    test('getProducts', () {
      // @formatter:off
      when(_dataMockService.getProducts())
          .thenAnswer((_) async => _dataMockService.getProducts());

      _dataMockService.getProducts().then((value) {
        expect(value[0].title, "Red Shirt");
        expect(value[3].description, 'Prepare any meal you want.');
      });
      // @formatter:on
    });

    test('getProductsQtde', () {
      expect(_dataMockService.getProductsQtde(), 4);
    });

    test('toggleFavoriteStatus', () {
      when(_mockService.toggleFavoriteStatus("p1"))
          .thenAnswer((_) async => true);

      _mockService
          .toggleFavoriteStatus("p1")
          .then((value) => expect(value, true));
    });

    test('getProductsByFilter', () {
      var listAll = _dataMockService.getProductsByFilter(EnumFilter.All);
      var listFav = _dataMockService.getProductsByFilter(EnumFilter.Fav);
      expect(listAll.length, 4);
      expect(listFav.length, 1);
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
