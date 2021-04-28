import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/modules/orders/entities/order.dart';
import 'package:shopingapp/app/modules/orders/repo/i_orders_repo.dart';

import '../../../../mocked_datasource/orders_mocked_datasource.dart';

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
    return Future.value(OrdersMockedDatasource().order());
  }

  @override
  Future<List<Order>> getOrders() {
    return Future.value(OrdersMockedDatasource().orders());
  }
}

class OrdersMockedRepoEmptyDb extends Mock implements IOrdersRepo {
  @override
  Future<Order> addOrder(Order order) async {
    return Future.value(OrdersMockedDatasource().order());
  }

  @override
  Future<List<Order>> getOrders() {
    return Future.value(OrdersMockedDatasource().ordersEmpty());
  }
}

class OrdersInjectMockedRepo extends Mock implements IOrdersRepo {}
