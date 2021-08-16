import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'app/modules/inventory/view/inventory_view_edit_functional_test.dart';
import 'app/modules/inventory/view/inventory_view_functional_test.dart';
import 'app/modules/inventory/view/inventory_view_validation_funtional_test.dart';
import 'app/modules/orders/view/orders_view_functional_test.dart';
import 'app/modules/overview/view/overview_details_functional_test.dart';
import 'app/modules/overview/view/overview_view_functional_test.dart';
import 'config/tests_config.dart';
import 'config/titles/inventory_test_titles.dart';
import 'config/titles/orders_test_titles.dart';
import 'config/titles/overview_test_titles.dart';
import 'groups/components_test_groups.dart';
import 'groups/inventory_test_groups.dart';
import 'groups/orders_test_groups.dart';
import 'groups/overview_test_groups.dart';

void main() {
  // NO ERASE: String.fromEnvironment => MUST BE CONSTANT!!!
  const _env = String.fromEnvironment("testType", defaultValue: WIDGET_TEST);
  print("ENV_VAR_TEST_TYPE: ${_env.toString()}");
  if (_env == WIDGET_TEST) _unitTests();
  if (_env == INTEGRATION_TEST) _integrationTests();
  if (_env != WIDGET_TEST && _env != INTEGRATION_TEST) print('TestType not Found.');
}

void _unitTests() {
  final _skipGroup = false;

  // CartTestGroups().groups(_skipGroup); // <<<<<<<<<<<<< BUG 01
  InventoryTestGroups().groups(_skipGroup);
  OrdersTestGroups().groups(_skipGroup);
  ComponentsTestGroups().groups(_skipGroup);

  //-----------------------------------------------------
  OverviewTestGroups().groups(_skipGroup);
}

void _integrationTests() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final _skipGroup = false;

  group(
    OrdersTestTitles.ORDERS_GROUP_TITLE,
    OrdersViewTest(testType: INTEGRATION_TEST).functional,
    skip: _skipGroup, // no erase: 'skip-group' overrides the internal 'skip-methods'
  );

  group(
    InventoryTestTitles.INV_GROUP_TITLE,
    InventoryViewTest(testType: INTEGRATION_TEST).functional,
    skip: _skipGroup,
  );

  group(
    InventoryTestTitles.INV_EDIT_GROUP_TITLE,
    InventoryViewEditTest(testType: INTEGRATION_TEST).functional,
    skip: _skipGroup,
  );

  group(
    InventoryTestTitles.INV_VALID_GROUP_TITLE,
    InventoryViewValidationFunctionalTest(testType: INTEGRATION_TEST).functional,
    skip: _skipGroup,
  );

  //------------------------------------------------------
  group(
    OverviewTestTitles.OVERVIEW_GROUP_TITLE,
    OverviewViewTest(testType: INTEGRATION_TEST).functional,
    skip: _skipGroup,
  );

  group(
    OverviewTestTitles.OVERVIEW_DETAIL_GROUP_TITLE,
    OverviewDetailsTest(testType: INTEGRATION_TEST).functional,
    skip: true,
  );
}
