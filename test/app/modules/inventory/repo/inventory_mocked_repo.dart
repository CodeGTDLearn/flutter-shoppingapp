import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/inventory/repo/i_inventory_repo.dart';

import '../../../../mocked_datasource/products_mocked_datasource.dart';

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
  *     - Testes independemente de WebServide ou DB
  *****************************************************/
class InventoryMockedRepo extends Mock implements IInventoryRepo {
  @override
  Future<int> deleteProduct(String id) {
    // @formatter:off
    final found = ProductsMockedDatasource()
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
  Future<List<Product>> getProducts() async {
    return Future.value(ProductsMockedDatasource().products());
  }

  @override
  Future<Product> addProduct(Product product) {
    var returnedMockedProduct = ProductsMockedDatasource().product();
    returnedMockedProduct.id = Faker().randomGenerator.string(7, min: 7);
    return Future.value(returnedMockedProduct);
  }

  @override
  Future<int> updateProduct(Product product) {
    // return Future.value(200);
    // @formatter:off
    final found = ProductsMockedDatasource()
        .products()
        .firstWhere((item) => item.id == product.id,
          orElse: () {
            return null;
          });
    return found == null ? Future.value(500) : Future.value(200);
    // @formatter:on
  }
}

class InventoryInjectMockedRepo extends Mock
    implements IInventoryRepo {}

class InventoryMockedRepoFail extends Mock implements IInventoryRepo {
  @override
  Future<int> deleteProduct(String id) {
    return Future.value(400);
  }

  @override
  Future<List<Product>> getProducts() {
    return Future.value(ProductsMockedDatasource().productsEmpty());
  }

  @override
  Future<Product> addProduct(Product product) {
    return Future.value(ProductsMockedDatasource().productNull());
  }

  @override
  Future<int> updateProduct(Product product) {
    return Future.value(400);
  }
}
