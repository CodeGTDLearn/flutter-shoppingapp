import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'app/core/components/custom_drawer_test.dart';
import 'app/core/components/custom_indicator_test.dart';
import 'app/modules/cart/view/cart_view_test.dart';
import 'app/modules/inventory/view/inventory_view_edit_test.dart';
import 'app/modules/inventory/view/inventory_view_test.dart';
import 'app/modules/inventory/view/inventory_view_validation_test.dart';
import 'app/modules/orders/view/orders_view_test.dart';
import 'app/modules/overview/view/overview_view_test.dart';
import 'config/groups/cart_test_groups.dart';
import 'config/groups/components_test_groups_drawwer.dart';
import 'config/groups/components_test_groups_progres_indic.dart';
import 'config/groups/inventory_test_groups.dart';
import 'config/groups/orders_test_groups.dart';
import 'config/groups/overview_test_groups.dart';
import 'config/tests_properties.dart';
import 'config/titles/cart_tests_titles.dart';
import 'config/titles/components_tests_drawwer_titles.dart';
import 'config/titles/components_tests_progres_indic_titles.dart';
import 'config/titles/inventory_tests_titles.dart';
import 'config/titles/orders_tests_titles.dart';
import 'config/titles/overview_tests_titles.dart';
import 'config/titles/testdb_check_titles.dart';
import 'datasource/datasource_loader.dart';

void main() {
  // NO ERASE:  String.fromEnvironment => MUST BE CONSTANT!!!
  const _env = String.fromEnvironment("testType", defaultValue: WIDGET_TEST);
  print("ENV_VAR_TEST_TYPE: ${_env.toString()}");
  if (_env == WIDGET_TEST) _unitTests();
  if (_env == INTEGRATION_TEST) _integrationTests();
  if (_env != WIDGET_TEST && _env != INTEGRATION_TEST) print('TestType not Found.');
}

void _unitTests() {
  final SKIP_GROUP = false;

  CartTestGroups().groups(skipGroup: SKIP_GROUP);
  OrdersTestGroups().groups(skipGroup: SKIP_GROUP);
  OverviewTestGroups().groups(skipGroup: SKIP_GROUP);
  InventoryTestGroups().groups(skipGroup: SKIP_GROUP);
  ComponentsTestGroupsDrawwer().groups(skipGroup: SKIP_GROUP);
  ComponentsTestGroupsProgresIndicator().groups(skipGroup: SKIP_GROUP);
}

void _integrationTests() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final SKIP_GROUP = true; //skip-group overrides the internal skip-methods

  group(
    TestDbCheckTitles.GROUP_TITLE,
    DatasourceLoader().loading,
    skip: false, // false all-the-time
  );

  group(
    OrdersTestsTitles.GROUP_TITLE,
    OrdersViewTest(testType: INTEGRATION_TEST).functional,
    skip: SKIP_GROUP,
  );

  group(
    InventoryTestsTitles.GROUP_TITLE,
    InventoryViewTest(testType: INTEGRATION_TEST).functional,
    skip: SKIP_GROUP,
  );

  group(
    InventoryTestsTitles.EDIT_GROUP_TITLE,
    InventoryViewEditTest(testType: INTEGRATION_TEST).functional,
    skip: SKIP_GROUP,
  );

  group(
    InventoryTestsTitles.VALID_GROUP_TITLE,
    InventoryViewValidationTest(testType: INTEGRATION_TEST).functional,
    skip: SKIP_GROUP,
  );

  group(
    OverviewTestsTitles.GROUP_TITLE,
    OverviewViewTest(testType: INTEGRATION_TEST).functional,
    skip: SKIP_GROUP,
  );

  group(
    CartTestsTitles.GROUP_TITLE,
    CartViewTest(testType: INTEGRATION_TEST).functional,
    skip: false,
  );

  group(
    ComponentsTestsDrawwerTitles.GROUP_TITLE,
    CustomDrawerTest(testType: INTEGRATION_TEST).functional,
    skip: SKIP_GROUP,
  );

  group(
    ComponentsTestsProgresIndicTitles.GROUP_TITLE,
    CustomIndicatorTest(testType: INTEGRATION_TEST).functional,
    skip: SKIP_GROUP,
  );
}
