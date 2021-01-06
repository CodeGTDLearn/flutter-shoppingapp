import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/managed_products/repo/i_managed_products_repo.dart';

import '../../../../test_utils/mocked_data_source/products_mocked_data.dart';

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
    // @formatter:off
    final found = ProductsMockedData()
        .products()
        .firstWhere((item) => item.id == id,
        orElse: () {
          return null;
        });
    return found == null ? Future.value(400) : Future.value(200);
    // @formatter:on
    // return Future.value(200);
  }

  @override
  Future<List<Product>> getProducts() {
    return Future.value(ProductsMockedData().products());
  }

  @override
  Future<Product> addProduct(Product product) {
    var returnedMockedProduct = ProductsMockedData().product();
    returnedMockedProduct.id = Faker().randomGenerator.string(7, min: 7);
    return Future.value(returnedMockedProduct);
  }

  @override
  Future<int> updateProduct(Product product) {
    // @formatter:off
    final found = ProductsMockedData()
        .products()
        .firstWhere((item) => item.id == product.id,
          orElse: () {
            return null;
          });
    return found == null ? Future.value(400) : Future.value(200);
    // @formatter:on
  }
}

class ManagedProductsInjectMockRepo extends Mock
    implements IManagedProductsRepo {}

class ManagedProductsMockRepoFail extends Mock implements IManagedProductsRepo {
  @override
  Future<int> deleteProduct(String id) {
    return Future.value(400);
  }

  @override
  Future<List<Product>> getProducts() {
    return Future.value(ProductsMockedData().productsEmpty());
  }

  @override
  Future<Product> addProduct(Product product) {
    return Future.value(ProductsMockedData().productEmpty());
  }

  @override
  Future<int> updateProduct(Product product) {
    return Future.value(400);
  }
}
