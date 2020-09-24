import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';
import 'package:test/test.dart';

import 'overview_service_mock.dart';

void main() {
  IOverviewService _predMockService;
  IOverviewService _customMockService;

  setUp(() {
    _predMockService = PredefinedMockService();
    _customMockService = CustomMockService();
  });

  group('Overview | Service | Sucessful', () {
    test('dataSavingAllProducts = Elements', () {
      var list = _predMockService.dataSavingAllProducts;
      expect(list[0].title, "Red Shirt");
      expect(list[3].description, 'Prepare any meal you want.');
    });

    test('dataSavingFavoritesProducts = Elements', () {
      var list = _predMockService.dataSavingFavoritesProducts;
      expect(list[0].isFavorite, true);
    });

    test('getFavoritesQtde', () {
      expect(_customMockService.getFavoritesQtde(), 1);
    });

    test('getProductById', () {
      var list = _predMockService.dataSavingAllProducts;
      expect(_customMockService.getProductById("p1"), list[0]);
    });

    test('getProducts = Elements', () {
      _predMockService.getProducts().then((value) {
        expect(value[0].title, "Red Shirt");
        expect(value[3].description, 'Prepare any meal you want.');
      });
    });

    test('getProductsQtde', () {
      expect(_customMockService.getProductsQtde(), 4);
    });

    test('toggleFavoriteStatus = p1', () {
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
