import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'app/core/global_widgets/custom_drawer_test.dart';
import 'app/core/global_widgets/custom_indicator_test.dart';
import 'app/core/groups/custom_appbar_test_groups.dart';
import 'app/core/groups/custom_drawer_test_groups.dart';
import 'app/core/groups/custom_indicator_test_groups.dart';
import 'app/core/test_titles/custom_appbar_test_titles.dart';
import 'app/core/test_titles/custom_drawer_test_titles.dart';
import 'app/core/test_titles/custom_indicator_test_titles.dart';
import 'app/core/test_titles/testdb_check_titles.dart';
import 'app/modules/cart/core/cart_test_groups.dart';
import 'app/modules/cart/core/cart_test_titles.dart';
import 'app/modules/cart/view/cart_view_test.dart';
import 'app/modules/inventory/core/inventory_test_groups.dart';
import 'app/modules/inventory/core/inventory_test_titles.dart';
import 'app/modules/inventory/view/inventory_view_edit_test.dart';
import 'app/modules/inventory/view/inventory_view_test.dart';
import 'app/modules/inventory/view/inventory_view_validation_test.dart';
import 'app/modules/orders/core/orders_test_groups.dart';
import 'app/modules/orders/core/orders_test_titles.dart';
import 'app/modules/orders/view/orders_view_test.dart';
import 'app/modules/overview/components/custom_appbar_test.dart';
import 'app/modules/overview/core/overview_test_groups.dart';
import 'app/modules/overview/core/overview_test_titles.dart';
import 'app/modules/overview/view/overview_view_test.dart';
import 'config/app_tests_properties.dart';
import 'config/datasource/mocked_datasource_loader.dart';

void main() {
  // NO REMOVE:  String.fromEnvironment => MUST BE CONSTANT!!!
  const _env = String.fromEnvironment("testType", defaultValue: WIDGET_TEST);
  if (_env == WIDGET_TEST) _unitTests();
  if (_env == INTEGRATION_TEST) _integrationTests();
  if (_env != WIDGET_TEST && _env != INTEGRATION_TEST) print('TestType invalid.');
}

// ISOLATED STATE:
// MOSTLY, OF WIDGET-TESTS HAVE ISOLATED TEST
// MEANING, IN THE ALL METHODS 'FOR-EACH' A NEW MOCKED-DATASOURCE
// IS LOADED, THEREFORE, EACH THE TESTS CAN HAVE ITS OWN STATE
void _unitTests() {
  final SKIP_GROUP = true;

  CartTestGroups().groups(skipGroup: false);
  InventoryTestGroups().groups(skipGroup: SKIP_GROUP);
  OrdersTestGroups().groups(skipGroup: SKIP_GROUP);
  OverviewTestGroups().groups(skipGroup: SKIP_GROUP);
  CustomAppbarTestGroups().groups(skipGroup: SKIP_GROUP);
  CustomDrawerTestGroups().groups(skipGroup: SKIP_GROUP);
  CustomIndicatorTestGroups().groups(skipGroup: SKIP_GROUP);
}

// SHARED STATE:
// ONCE, A REAL DATABASE (FIREBASE) IS BEING USED
// IT IS IMPOSSIBLE ISOLATE THE STATE FOR EACH-TEST
// HENCE, 'ALL-TESTS' SHOULD BE EXECUTED TOGETHER
// BECAUSE THE DB-STATE SHARING.
void _integrationTests() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final SKIP_GROUP = false; //skip-group overrides the internal skip-methods

  group(
    TestDbCheckTitles.GROUP_TITLE,
    () => MockedDatasourceLoader(TOTAL_SAMPLE_DATA_ITEMS).load(start: true),
    skip: false, // false all-the-time
  );

  group(
      OrdersTestTitles.GROUP_TITLE, OrdersViewTest(testType: INTEGRATION_TEST).functional,
      skip: SKIP_GROUP);

  group(InventoryTestTitles.GROUP_TITLE,
      InventoryViewTest(testType: INTEGRATION_TEST).functional,
      skip: SKIP_GROUP);

  group(InventoryTestTitles.EDIT_GROUP_TITLE,
      InventoryViewEditTest(testType: INTEGRATION_TEST).functional,
      skip: SKIP_GROUP);

  group(InventoryTestTitles.VALID_GROUP_TITLE,
      InventoryViewValidationTest(testType: INTEGRATION_TEST).functional,
      skip: SKIP_GROUP);

  group(OverviewTestTitles.GROUP_TITLE,
      OverviewViewTest(testType: INTEGRATION_TEST).functional,
      skip: SKIP_GROUP);

  group(CartTestTitles.GROUP_TITLE, CartViewTest(testType: INTEGRATION_TEST).functional,
      skip: SKIP_GROUP);

  group(CustomDrawerTestTitles.GROUP_TITLE,
      CustomDrawerTest(testType: INTEGRATION_TEST).functional,
      skip: SKIP_GROUP);

  group(CustomIndicatorTestTitles.GROUP_TITLE,
      CustomIndicatorTest(testType: INTEGRATION_TEST).functional,
      skip: SKIP_GROUP);

  group(CustomAppbarTestTitles.GROUP_TITLE,
      CustomAppbarTest(testType: INTEGRATION_TEST).functional,
      skip: SKIP_GROUP);
}