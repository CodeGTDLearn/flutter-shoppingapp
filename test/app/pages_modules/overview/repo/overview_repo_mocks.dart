import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';

import '../utils/mocked_data_source.dart';

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
* *
*--> LINK: https://flutter.dev/docs/cookbook/testing/unit/mocking
*****************************************************/
class DataMockRepo extends Mock implements IOverviewRepo {
  @override
  Future<List<Product>> getProducts() async {
    return Future.value(MockedDataSource().products());
  }

  @override
  Future<int> updateProduct(Product product) {
    return Future.value(200);
  }
}

class WhenMockRepo extends Mock implements IOverviewRepo {}
