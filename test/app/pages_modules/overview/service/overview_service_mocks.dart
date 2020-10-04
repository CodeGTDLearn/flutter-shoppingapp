import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';

import '../repo/overview_repo_mocks.dart';
import '../utils/mocked_data_source.dart';

class DataMockService extends Mock implements IOverviewService {

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
*     They are clones/implementation of Real classes, and the
*     TESTS ARE DONE ON THAT. "NOT" in the ACTUAL classes
*
*--> LINK: https://flutter.dev/docs/cookbook/testing/unit/mocking
*****************************************************/

  @override
  List<Product> get dataSavingAllProducts {
    return MockedDataSource().products();
  }

  @override
  List<Product> get dataSavingFavoritesProducts {
    return MockedDataSource().favoritesProducts();
  }

  @override
  int getFavoritesQtde() {
    return MockedDataSource().favoritesProducts().length;
  }

  @override
  Product getProductById(String id) {
    return MockedDataSource().productById(id);
  }

  @override
  Future<List<Product>> getProducts() async {
    return Future.value(MockedDataSource().products());
  }

  @override
  List<Product> getProductsByFilter(EnumFilter filter) {
    return MockedDataSource().productsByFilter(filter);
  }

  @override
  int getProductsQtde() {
    return MockedDataSource().products().length;
  }

  @override
  Future<bool> toggleFavoriteStatus(String id) {
    List<Product> result = MockedDataSource().products();
    result.forEach((element) {
      if (element.id == id) element.isFavorite = !element.isFavorite;
    });
    return Future.value(true);
  }
}

class WhenMockService extends Mock implements IOverviewService {}
