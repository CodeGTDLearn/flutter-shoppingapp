import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';

// class MockService extends Mock implements IOverviewService {
//
//   /* **************************************************
//   *
//   *--> TIPOS DE MOCK
//   *    A) DATA MOCKS:
//   *      DATA Mocks does NOT ALLOW
//   *      the "WHEN"
//   *     because they has predefined responses)
//   *
//   *    B) "INJECTABLE" MOCKS:
//   *      They are "Plain Mocks" (NO predefined responses);
//   *      thus, they ALLOW the "WHEN"
//   *
//   *--> CONCEITO:
//   *     Eles sao clones das Classes reais (replica de comportamento+retorno).
//   *     Testes sao realizados em Mocks, NUNCA em classes reais
//   *     FONTE: https://flutter.dev/docs/cookbook/testing/unit/mocking
//   *
//   * *****************************************************/
//
//   @override
//   List<Product> get localDataAllProducts {
//     return MockedDataSource().products();
//   }
//
//   @override
//   List<Product> get localDataFavoritesProducts {
//     return MockedDataSource().favoritesProducts();
//   }
//
//   @override
//   int getFavoritesQtde() {
//     return MockedDataSource().favoritesProducts().length;
//   }
//
//   @override
//   Product getProductById(String id) {
//     return MockedDataSource().productById(id);
//   }
//
//   @override
//   Future<List<Product>> getProducts() async {
//     return Future.value(MockedDataSource().products());
//   }
//
//   @override
//   List<Product> getProductsByFilter(EnumFilter filter) {
//     return MockedDataSource().productsByFilter(filter);
//   }
//
//   @override
//   int getProductsQtde() {
//     return MockedDataSource().products().length;
//   }
//
//   @override
//   Future<bool> toggleFavoriteStatus(String id) {
//     List<Product> result = MockedDataSource().products();
//     result.forEach((element) {
//       if (element.id == id) element.isFavorite = !element.isFavorite;
//     });
//     return Future.value(true);
//   }
// }

class InjectableMockService extends Mock implements IOverviewService {}
