import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/modules/inventory/service/i_inventory_service.dart';

//   /* **************************************************
//   *
//   *--> TIPOS DE MOCK
//   *    A) DATA MOCKS:
//   *      DATA Mocks does NOT ALLOW
//   *      the "WHEN"
//   *     because they has predefined responses)
//   *
//   *    B) "INJECTABLE" MOCKS:
//   *      They are "Plain Mocks" (NO predefined responses);
//   *      thus, they ALLOW the "WHEN"
//   *
//   *--> CONCEITO:
//   *     Eles sao clones das Classes reais (replica de comportamento+retorno).
//   *     Testes sao realizados em Mocks, NUNCA em classes reais
//   *     FONTE: https://flutter.dev/docs/cookbook/testing/unit/mocking
//   *
//   * *****************************************************/

class ManagedProductsInjectMockService extends Mock
    implements IInventoryService {}
