import 'package:test/test.dart';

import '../app/modules/inventory/inventory_controller_test.dart';
import '../app/modules/inventory/repo/inventory_repo_test.dart';
import '../app/modules/inventory/service/inventory_service_test.dart';
import '../app/modules/inventory/view/inventory_view_edit_functional_test.dart';
import '../app/modules/inventory/view/inventory_view_functional_test.dart';
import '../app/modules/inventory/view/inventory_view_validation_test.dart';
import '../config/app_tests_config.dart';
import '../config/inventory_test_config.dart';

class InventoryTestGroups {
  void groups(bool skipGroup) {
    group(
      InventoryTestConfig().REPO_TEST_TITLE,
      InventoryRepoTests.unit,
      skip: skipGroup, // 'skip-group' overrides the internal 'skip-methods'
    );

    group(
      InventoryTestConfig().SERVICE_TEST_TITLE,
      InventoryServiceTests.unit,
      skip: skipGroup,
    );

    group(
      InventoryTestConfig().CONTROLLER_TEST_TITLE,
      InventoryControllerTests.integration,
      skip: skipGroup,
    );

    group(
      "${InventoryTestConfig().VIEW_TEST_TITLE}",
      InventoryViewFunctionalTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );

    group(
      InventoryTestConfig().VIEW_TEST_VALID_TITLE,
      InventoryViewValidationTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );

    group(
      InventoryTestConfig().VIEW_EDIT_TEST_TITLE,
      InventoryViewEditFunctionalTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}
