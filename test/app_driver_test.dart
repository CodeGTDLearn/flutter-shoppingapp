import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'app/modules/inventory/view/inventory_view_edit_functional_test.dart';
import 'app/modules/inventory/view/inventory_view_functional_test.dart';
import 'app/modules/inventory/view/inventory_view_validation_test.dart';
import 'app/modules/orders/view/orders_view_functional_test.dart';
import 'app/modules/overview/view/overview_details_view_test.dart';
import 'app/modules/overview/view/overview_view_test.dart';
import 'config/app_tests_config.dart';
import 'groups/components_test_groups.dart';
import 'groups/inventory_test_groups.dart';
import 'groups/orders_test_groups.dart';
import 'groups/overview_test_groups.dart';

void main() {
  const _type = String.fromEnvironment('myVar', defaultValue: WIDGET_TEST);
  if (_type == WIDGET_TEST) _unitTests();
  if (_type == INTEGRATION_TEST) _integrationTests();
  if (_type != WIDGET_TEST && _type != INTEGRATION_TEST) print('TestType not Found.');
}

void _unitTests() {
  // CartTestGroups().groups(); //<<<<<<<<<<<<< BUG 01

  OverviewTestGroups().groups();
  // InventoryTestGroups().groups();
  // OrdersTestGroups().groups();
  // ComponentsTestGroups().groups();
}

void _integrationTests() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // group('Orders|Integration-Tests: ',
  //     OrdersViewFunctionalTest(testType: INTEGRATION_TEST).functional);
  //
  // group('Inventory|Integration-Tests: ',
  //     InventoryViewFunctionalTest(testType: INTEGRATION_TEST).functional);
  //
  // group('Inventory|Integration-Tests: ',
  //     InventoryViewValidationTest(testType: INTEGRATION_TEST).functional);
  //
  // group('Inventory|Integration-Tests: ',
  //     InventoryViewEditFunctionalTest(testType: INTEGRATION_TEST).functional);

  group(
    'OverView|Integration-Tests: ',
    OverviewViewTest(testType: WIDGET_TEST).functional,
  );

  // group('OverView|Details|Integration-Tests: ',
  //     OverviewDetailsViewTests(testType: WIDGET_TEST).functional);
}
