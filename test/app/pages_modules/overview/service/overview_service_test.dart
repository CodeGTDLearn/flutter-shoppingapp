import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
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
  IOverviewService _predMockService, _customMockService, _service;
  IOverviewRepo _mockRepo;

  setUp(() {
    OverviewBindings().dependencies();
    _service = OverviewService();
    _mockRepo = DataMockRepo();
    // _predMockService = PredefinedMockService();
    _customMockService = CustomMockService();
  });

  group('Overview | Service', () {
    test('dataSavingAllProducts', () {
      var list = _predMockService.dataSavingAllProducts;
      expect(list[0].title, "Red Shirt");
      expect(list[3].description, 'Prepare any meal you want.');
    });

    test('dataSavingFavoritesProducts', () {
      var list = _predMockService.dataSavingFavoritesProducts;
      expect(list[0].isFavorite, true);
    });

    test('getFavoritesQtde', () {
      expect(_predMockService.getFavoritesQtde(), 1);
    });

    test('getProductById', () {
      var list = _predMockService.dataSavingAllProducts;
      expect(_predMockService.getProductById("p1").description,
          list[0].description);
    });

    test('getProducts', () {
      // @formatter:off
      when(_service.getProducts())
          .thenAnswer((_) async => _mockRepo.getProducts());

      _service.getProducts().then((value) {
        expect(value[0].title, "Red Shirt");
        expect(value[3].description, 'Prepare any meal you want.');
      });
      // @formatter:on
    });

    test('getProductsQtde', () {
      expect(_predMockService.getProductsQtde(), 4);
    });

    test('toggleFavoriteStatus', () {
      when(_customMockService.toggleFavoriteStatus("p1"))
          .thenAnswer((_) async => true);

      _customMockService
          .toggleFavoriteStatus("p1")
          .then((value) => expect(value, true));
    });

    test('getProductsByFilter', () {
      var listAll = _predMockService.getProductsByFilter(EnumFilter.All);
      var listFav = _predMockService.getProductsByFilter(EnumFilter.Fav);
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
