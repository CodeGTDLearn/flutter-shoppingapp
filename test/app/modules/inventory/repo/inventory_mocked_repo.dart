import 'package:faker/faker.dart';
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
class InventoryMockedRepo extends Mock implements IInventoryRepo {
  @override
  Future<int> deleteProduct(String id) {
    // final found = MockedDatasource().products().firstWhere((item) => item.id == id);
    // return found == null ? Future.value(400) : Future.value(200);

    return Future.value(200);
  }

  @override
  Future<List<Product>> getProducts() async {
    return Future.value(MockedDatasource().products());
  }

  @override
  Future<Product> addProduct(Product product) {
    var returnedMockedProduct = MockedDatasource().product();
    returnedMockedProduct.id = Faker().randomGenerator.string(7, min: 7);
    return Future.value(returnedMockedProduct);
  }

  @override
  Future<int> updateProduct(Product product) {
    var result = 500;
    MockedDatasource().products().forEach((item) {
      if (item.id == product.id) result = 200;
    });
    return Future.value(result);
  }
}
