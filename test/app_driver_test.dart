import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'app/core/components/drawwer_test.dart';
import 'app/modules/cart/view/cart_view_test.dart';
import 'app/modules/inventory/view/inventory_view_edit_test.dart';
import 'app/modules/inventory/view/inventory_view_test.dart';
import 'app/modules/inventory/view/inventory_view_validation_test.dart';
import 'app/modules/orders/view/orders_view_test.dart';
import 'app/modules/overview/view/overview_view_test.dart';
import 'config/groups/cart_test_groups.dart';
import 'config/groups/components_test_groups.dart';
import 'config/groups/inventory_test_groups.dart';
import 'config/groups/orders_test_groups.dart';
import 'config/groups/overview_test_groups.dart';
import 'config/tests_properties.dart';
import 'config/titles/cart_tests_titles.dart';
import 'config/titles/components_tests_titles.dart';
import 'config/titles/inventory_tests_titles.dart';
import 'config/titles/orders_tests_titles.dart';
import 'config/titles/overview_tests_titles.dart';
import 'config/titles/testdb_check_titles.dart';
import 'tests_datasource/load_db_test.dart';

void main() {
  // NO ERASE:  String.fromEnvironment => MUST BE CONSTANT!!!
  const _env = String.fromEnvironment("testType", defaultValue: WIDGET_TEST);
  print("ENV_VAR_TEST_TYPE: ${_env.toString()}");
  if (_env == WIDGET_TEST) _unitTests();
  if (_env == INTEGRATION_TEST) _integrationTests();
  if (_env != WIDGET_TEST && _env != INTEGRATION_TEST) print('TestType not Found.');
}

void _unitTests() {
  final skip_group = false;

  CartTestGroups().groups(skipGroup: skip_group);
  OrdersTestGroups().groups(skipGroup: skip_group);
  OverviewTestGroups().groups(skipGroup: skip_group);
  InventoryTestGroups().groups(skipGroup: skip_group);
  ComponentsTestGroups().groups(skipGroup: true);
}

void _integrationTests() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final skip_group = true; //skip-group overrides the internal skip-methods

  group(
    TestDbCheckTitles.GROUP_TITLE,
    DbTest().loading,
    skip: false,
  );

  group(
    OrdersTestsTitles.GROUP_TITLE,
    OrdersViewTest(testType: INTEGRATION_TEST).functional,
    skip: skip_group,
  );

  group(
    InventoryTestsTitles.GROUP_TITLE,
    InventoryViewTest(testType: INTEGRATION_TEST).functional,
    skip: true,
  );

  group(
    InventoryTestsTitles.EDIT_GROUP_TITLE,
    InventoryViewEditTest(testType: INTEGRATION_TEST).functional,
    skip: skip_group,
  );

  group(
    InventoryTestsTitles.VALID_GROUP_TITLE,
    InventoryViewValidationTest(isWidgetTest: INTEGRATION_TEST).functional,
    skip: true,
  );

  group(
    OverviewTestsTitles.GROUP_TITLE,
    OverviewViewTest(testType: INTEGRATION_TEST).functional,
    skip: skip_group,
  );

  group(
    CartTestsTitles.GROUP_TITLE,
    CartViewTest(testType: INTEGRATION_TEST).functional,
    skip: skip_group,
  );

  group(
    ComponentsTestsTitles.GROUP_TITLE_DRAWWER,
    DrawwerTest(testType: INTEGRATION_TEST).functional,
    skip: true,
  );
}
