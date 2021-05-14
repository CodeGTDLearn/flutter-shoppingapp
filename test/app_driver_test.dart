import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'app/core/components/components_test_groups.dart';
import 'app/modules/cart/cart_test_groups.dart';
import 'app/modules/inventory/inventory_test_groups.dart';
import 'app/modules/orders/orders_test_groups.dart';
import 'app/modules/orders/view/orders_view_functional_test.dart';
import 'app/modules/overview/overview_test_groups.dart';
import 'app_test_config.dart';

void main() {
  const _testType = String.fromEnvironment('myVar', defaultValue: WIDGET_TESTS);
  _testType == WIDGET_TESTS ? _widgetTests() : _integrationTests();
}

void _widgetTests() {
  CartTest().groups();
  OrdersTest().groups();
  OverviewTest().groups();
  InventoryTest().groups();
  ComponentsTest().groups();
}

void _integrationTests() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Orders|Integration-GUI-Tests: ',
      OrdersViewFunctionalTest(testType: INTEGRATION_TESTS).functional);
}
