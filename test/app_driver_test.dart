import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'app/modules/inventory/view/inventory_view_edit_functional_test.dart';
import 'app/modules/inventory/view/inventory_view_functional_test.dart';
import 'app/modules/inventory/view/inventory_view_validation_test.dart';
import 'app/modules/orders/view/orders_view_functional_test.dart';
import 'app/modules/overview/view/overview_details_view_test.dart';
import 'app/modules/overview/view/overview_view_test.dart';
import 'config/app_tests_config.dart';
import 'config/inventory_test_config.dart';
import 'config/orders_test_config.dart';
import 'config/overview_test_config.dart';
import 'groups/components_test_groups.dart';
import 'groups/inventory_test_groups.dart';
import 'groups/orders_test_groups.dart';
import 'groups/overview_test_groups.dart';

void main() {
  const _type = String.fromEnvironment('testType', defaultValue: WIDGET_TEST);
  if (_type == WIDGET_TEST) _unitTests();
  if (_type == INTEGRATION_TEST) _integrationTests();
  if (_type != WIDGET_TEST && _type != INTEGRATION_TEST) print('TestType not Found.');
}

void _unitTests() {
  // CartTestGroups().groups(); //<<<<<<<<<<<<< BUG 01

  OverviewTestGroups().groups();
  InventoryTestGroups().groups();
  OrdersTestGroups().groups();
  ComponentsTestGroups().groups();
}

void _integrationTests() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    OrdersTestConfig.ORDERS_GROUP_TITLE,
    OrdersViewFunctionalTest(testType: INTEGRATION_TEST).functional,
  );

  group(
    InventoryTestConfig.INVENTORY_GROUP_TITLE,
    InventoryViewFunctionalTest(testType: INTEGRATION_TEST).functional,
  );

  group(
    InventoryTestConfig.INVENTORY_EDIT_GROUP_TITLE,
    InventoryViewEditFunctionalTest(testType: INTEGRATION_TEST).functional,
  );

  group(
    InventoryTestConfig.INVENTORY_VALIDATION_GROUP_TITLE,
    InventoryViewValidationTest(testType: INTEGRATION_TEST).functional,
  );

  // group(
  //   OverviewTestConfig.OVERVIEW_GROUP_TITLE,
  //   OverviewViewTest(testType: WIDGET_TEST).functional,
  // );

  // group(OverviewTestConfig.OVERVIEW_DETAIL_GROUP_TITLE,
  //     OverviewDetailsViewTest(testType: WIDGET_TEST).functional);
}
