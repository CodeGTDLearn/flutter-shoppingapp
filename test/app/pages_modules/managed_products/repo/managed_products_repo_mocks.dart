import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/managed_products/repo/i_managed_products_repo.dart';

import '../../../../mocked_data_source/products_mocked_data.dart';

/* **************************************************
  *--> TIPOS DE MOCK
  *    A) DATA MOCKS:
  *      DATA Mocks does NOT ALLOW
  *      the "WHEN"
  *     (because they has predefined responses)
  *
  *    B) "INJECTABLE" MOCKS:
  *      They are "Plain Mocks" (NO predefined responses);
  *      thus, they ALLOW the "WHEN"
  *
  *--> CONCEITO:
  *     Eles sao clones das Classes reais (replica de comportamento+retorno).
  *     Testes sao realizados em Mocks, NUNCA em classes reais
  *     FONTE: https://flutter.dev/docs/cookbook/testing/unit/mocking
  *
  *--> VISAO PRATICA:
  *     Mocks permitem:
  *     - Testes mais rapidos, do que os feitos em WebService ou DB
  *     - Testes independemente de WebService ou DB
  *****************************************************/
class ManagedProductsMockRepo extends Mock implements IManagedProductsRepo {



  @override
  Future<int> deleteProduct(String id) {
    return Future.value(200);
  }

  @override
  Future<List<Product>> getProducts() {
    return Future.value(ProductsMockedData().products());
  }

  @override
  Future<Product> addProduct(Product product) {
    return Future.value(product);
  }

  @override
  Future<int> updateProduct(Product product) {
    return Future.value(200);
  }
}

class ManagedProductsInjectMockRepo extends Mock
    implements IManagedProductsRepo {}
