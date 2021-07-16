import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'app/modules/inventory/view/inventory_view_edit_functional_test.dart';
import 'app/modules/inventory/view/inventory_view_functional_test.dart';
import 'app/modules/inventory/view/inventory_view_validation_test.dart';
import 'app/modules/orders/view/orders_view_functional_test.dart';
import 'app/modules/overview/view/overview_details_functional_test.dart';
import 'app/modules/overview/view/overview_view_functional_test.dart';
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
  if (_type == WIDGET_TEST) _unitAndWidgetTests();
  if (_type == INTEGRATION_TEST) _integrationTests();
  if (_type != WIDGET_TEST && _type != INTEGRATION_TEST) print('TestType not Found.');
}

void _unitAndWidgetTests() {
  final skipGroup = true;

  // CartTestGroups().groups(skipGroup); //<<<<<<<<<<<<< BUG 01
  InventoryTestGroups().groups(skipGroup);
  OrdersTestGroups().groups(skipGroup);
  ComponentsTestGroups().groups(skipGroup);

  //-----------------------------------------------------
  OverviewTestGroups().groups(skipGroup);
}

void _integrationTests() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final skipGroup = true;

  group(
    OrdersTestConfig.ORDERS_GROUP_TITLE,
    OrdersViewFunctionalTest(testType: INTEGRATION_TEST).functional,
    skip: skipGroup, //'skip-group' overrides the internal 'skip-methods'
  );

  group(
    InventoryTestConfig.INVENTORY_GROUP_TITLE,
    InventoryViewFunctionalTest(testType: INTEGRATION_TEST).functional,
    skip: skipGroup,
  );

  group(
    InventoryTestConfig.INVENTORY_EDIT_GROUP_TITLE,
    InventoryViewEditFunctionalTest(testType: INTEGRATION_TEST).functional,
    skip: skipGroup,
  );

  group(
    InventoryTestConfig.INVENTORY_VALIDATION_GROUP_TITLE,
    InventoryViewValidationTest(testType: INTEGRATION_TEST).functional,
    skip: skipGroup,
  );

  //------------------------------------------------------
  group(
    OverviewTestConfig.OVERVIEW_GROUP_TITLE,
    OverviewViewFunctionalTest(testType: INTEGRATION_TEST).functional,
    skip: skipGroup,
  );

  group(
    OverviewTestConfig.OVERVIEW_DETAIL_GROUP_TITLE,
    OverviewDetailsFunctionalTest(testType: INTEGRATION_TEST).functional,
    skip: skipGroup,
  );
}
