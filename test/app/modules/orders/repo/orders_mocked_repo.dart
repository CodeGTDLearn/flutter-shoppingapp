import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/modules/orders/entity/order.dart';
import 'package:shopingapp/app/modules/orders/repo/i_orders_repo.dart';

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
class OrdersMockedRepo extends Mock implements IOrdersRepo {
  @override
  Future<Order> addOrder(Order order) async {
    return Future.value(MockedDatasource().order());
  }

  @override
  Future<List<Order>> getOrders() {
    return Future.value(MockedDatasource().orders());
  }
}