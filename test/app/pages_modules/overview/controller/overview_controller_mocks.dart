import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';


import '../../../../mock_data_source/mocked_data_source.dart';

class DataMockController{
  /* **************************************************
  *--> TIPOS DE MOCK
  *    A) DATA MOCKS:
  *      DATA Mocks does NOT ALLOW
  *      the "WHEN"
  *     because they has predefined responses)
  *
  *    B) MOCKS:
  *      They are "Plain Mocks"
  *      (because they has NOT predefined responses);
  *      thus, they ALLOW the "WHEN"
  *
  *--> CONCEITO:
  *     Eles sao clones das Classes reais (replica de comportamento+retorno).
  *     Testes sao realizados em Mocks, NUNCA em classes reais
  *     FONTE: https://flutter.dev/docs/cookbook/testing/unit/mocking
  *****************************************************/

  @override
  void onInit() {}

  @override
  void toggleFavoriteStatus(String id) {}

  @override
  void getProductsByFilter(EnumFilter filter) {}

  @override
  int getFavoritesQtde() {
    return MockedDataSource().favoritesProducts().length;
  }

  @override
  Product getProductById(String id) {
    return MockedDataSource().productById(id);
  }

  @override
  Future<List<Product>> getProducts() {
    return Future.value(MockedDataSource().products());
  }

  @override
  int getProductsQtde() {
    return MockedDataSource().products().length;
  }
}

// class WhenMockController extends Mock implements IOverviewController {}
