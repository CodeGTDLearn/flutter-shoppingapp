import 'package:test/test.dart';

import '../../../app_tests_config.dart';
import 'inventory_controller_test.dart';
import 'inventory_test_config.dart';
import 'repo/inventory_repo_test.dart';
import 'service/inventory_service_test.dart';
import 'view/inventory_view_edit_functional_test.dart';
import 'view/inventory_view_functional_test.dart';
import 'view/inventory_view_validation_test.dart';

class InventoryTest {
  void groups() {
    // group("${InventoryTestConfig().REPO_TEST_TITLE}", InventoryRepoTests.unit);
    // group("${InventoryTestConfig().SERVICE_TEST_TITLE}", InventoryServiceTests.unit);
    // group(
    //   "${InventoryTestConfig().CONTROLLER_TEST_TITLE}",
    //   InventoryControllerTests.integration,
    // );
    // group(
    //   "${InventoryTestConfig().VIEW_TEST_TITLE}",
    //   InventoryViewFunctionalTest(testType: WIDGET_TEST).functional,
    // );
    // group(
    //   "${InventoryTestConfig().VIEW_TEST_VALID_TITLE}",
    //   InventoryViewValidationTest(testType: WIDGET_TEST).functional,
    // );
    group(
      "${InventoryTestConfig().VIEW_EDIT_TEST_TITLE}",
      InventoryViewEditFunctionalTest().functional,
    );
  }
}
