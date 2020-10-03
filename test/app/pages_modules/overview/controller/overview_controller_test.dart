import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/i_overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/overview_firebase_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/pages_modules/overview/service/overview_service.dart';
import 'package:test/test.dart';

import '../service/overview_service_mocks.dart';
import '../utils/mocked_data_source.dart';
import 'overview_controller_mocks.dart';

void main() {
  IOverviewService _predMockService;
  IOverviewService _customMockService;
  IOverviewController _predMockController;

  OverviewController _controller;
  IOverviewService _service;
  IOverviewRepo _repo;

  var filteredProductsObs = <Product>[];
  var favoriteStatusObs = false;

  setUp(() {
    _predMockService = PredefinedMockService();
    _customMockService = CustomMockService();
    _predMockController = PredefinedMockController();

    _repo = OverviewFirebaseRepo();
    // _service = OverviewService();
    _controller = OverviewController();

    ;
  });

  group('Overview | Controller | Sucessful', () {
    test('onInit = Initial Observable loading', () {
      expect(_controller.filteredProductsObs.length, 0);
      _controller.filteredProductsObs.value = MockedDataSource().products();
      expect(_controller.filteredProductsObs.length, 4);
      expect(_controller.filteredProductsObs.value[0].title, "Red Shirt");
      expect(_controller.filteredProductsObs.value[3].description,
          'Prepare any meal you want.');
    });
    //
    // test('dataSavingFavoritesProducts = Elements', () {
    //   var list = _predMockService.dataSavingFavoritesProducts;
    //   expect(list[0].isFavorite, true);
    // });
    //
    // test('getFavoritesQtde', () {
    //   expect(_predMockService.getFavoritesQtde(), 1);
    // });
    //
    // test('getProductById', () {
    //   var list = _predMockService.dataSavingAllProducts;
    //   expect(_predMockService.getProductById("p1").description,
    //       list[0].description);
    // });
    //
    // test('getProducts = Elements', () {
    //   _predMockService.getProducts().then((value) {
    //     expect(value[0].title, "Red Shirt");
    //     expect(value[3].description, 'Prepare any meal you want.');
    //   });
    // });
    //
    // test('getProductsQtde', () {
    //   expect(_predMockService.getProductsQtde(), 4);
    // });
    //
    // test('toggleFavoriteStatus = p1', () {
    //   when(_customMockService.toggleFavoriteStatus("p1"))
    //       .thenAnswer((_) async => true);
    //
    //   _customMockService
    //       .toggleFavoriteStatus("p1")
    //       .then((value) => expect(value, true));
    // });
    //
    // test('getProductsByFilter', () {
    //   var listAll = _predMockService.getProductsByFilter(EnumFilter.All);
    //   var listFav = _predMockService.getProductsByFilter(EnumFilter.Fav);
    //   expect(listAll.length, 4);
    //   expect(listFav.length, 1);
    // });
  });
}
