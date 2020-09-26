import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';

import '../utils/mock_data.dart';

class PredefinedMockService extends Mock implements IOverviewService {
  /* **************************************************
*   A) PREDEFINED MOCKS:
*     Predefined Mocks does NOT ALLOW
*     the "WHEN" clause (because they has predefined responses)
*     Although, they extends Mockito (Mock)
*
*     Mocks com Responses Predefinidas(PredefinedMockRepo)
*     NAO PERMITEM a clausula "WHEN" (pois possuem retorno predefinido)
*     Embora, eles extendam o Mockito("Mock)
*
*   B) Custom MOCKS:
*     Custom Mocks (CustomMockRepo)
*     are "Plain Mocks" (because they has NOT predefined responses);
*     thus, they ALLOW the "Custom" clause
*
*     Custom Mocks sao Mocks Zerados(sem qqer retorno predefinido)
*     portanto, PERMITEM a clausula "Custom"
*****************************************************/
  @override
  List<Product> get dataSavingAllProducts {
    return MockData().products();
  }

  @override
  List<Product> get dataSavingFavoritesProducts {
    return MockData().favoritesProducts();
  }

  @override
  int getFavoritesQtde() {
    return MockData().favoritesProducts().length;
  }

  @override
  Product getProductById(String id) {
    return MockData().productById(id);
  }

  @override
  Future<List<Product>> getProducts() async {
    return Future.value(MockData().products());
  }

  @override
  List<Product> getProductsByFilter(EnumFilter filter) {
    return MockData().productsByFilter(filter);
  }

  @override
  int getProductsQtde() {
    return MockData().products().length;
  }

  @override
  Future<bool> toggleFavoriteStatus(String id) {
    List<Product> result = MockData().products();
    result.forEach((element) {
      if (element.id == id) element.isFavorite = !element.isFavorite;
    });
    return Future.value(true);
  }
}

class CustomMockService extends Mock implements IOverviewService {}
