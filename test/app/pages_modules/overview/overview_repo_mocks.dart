import 'dart:convert';
import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';

/* **************************************************
*   DEFINED_MOCK_REPO:
*   Predefined Mock Repo(PredefinedMockRepo),
*   does NOT ALLOW the "WHEN" clause
*   Although, they extends Mockito (Mock)
*
*   Mocks Com Responses Predefinidas(PredefinedMockRepo)
*   NAO PERMITEM a clausula "WHEN"
*   Embora, eles extendam o Mockito("Mock)
* 
*   CUSTOM_MOCK_REPO:
*   Custom Mocks Repos(CustomMockRepo)
*   are "Plain Mocks"; thus, they ALLOW
*   the "WHEN" clause
*
*   Mocks Repo customizados sao Mocks Zerados
*   portanto, PERMITEM a clausula "WHEN"
*****************************************************/
class PredefinedMockRepo extends Mock implements IOverviewRepo {
  @override
  Future<List<Product>> getProducts() async {
    final file = File('assets/mocks_returns/products.json');
    final json = jsonDecode(await file.readAsString());
    var result = json.map<Product>((json) => Product.fromJson(json)).toList();
    return Future.value(result);
  }

  @override
  Future<int> updateProduct(Product product) {
    return Future.value(200);
  }
}

class CustomMockRepo extends Mock implements IOverviewRepo {}
