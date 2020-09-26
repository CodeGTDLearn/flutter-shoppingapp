import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';

import '../utils/mock_data.dart';

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
class PredefinedMockRepo extends Mock implements IOverviewRepo {
  @override
  Future<List<Product>> getProducts() async {
    return Future.value(MockData().products());
  }

  @override
  Future<int> updateProduct(Product product) {
    return Future.value(200);
  }
}

class CustomMockRepo extends Mock implements IOverviewRepo {}
