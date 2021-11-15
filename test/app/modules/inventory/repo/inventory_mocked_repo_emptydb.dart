import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';
import 'package:shopingapp/app/modules/inventory/repo/i_inventory_repo.dart';

import '../../../../datasource/mocked_datasource.dart';

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
class InventoryMockedRepoEmptyDb extends Mock implements IInventoryRepo {
  @override
  Future<int> deleteProduct(String id) {
    return Future.value(400);
  }

  @override
  Future<List<Product>> getProducts() {
    return Future.value(MockedDatasource().productsEmpty());
  }

  @override
  Future<Product> addProduct(Product product) {
    return Future.value(MockedDatasource().product());
  }

  @override
  Future<int> updateProduct(Product product) {
    return Future.value(400);
  }
}