import 'package:flutter_test/flutter_test.dart';

import '../app/modules/inventory/inventory_controller_test.dart';
import '../app/modules/inventory/repo/inventory_repo_test.dart';
import '../app/modules/inventory/service/inventory_service_test.dart';
import '../app/modules/inventory/view/inventory_view_edit_functional_test.dart';
import '../app/modules/inventory/view/inventory_view_functional_test.dart';
import '../app/modules/inventory/view/inventory_view_validation_funtional_test.dart';
import '../config/tests_config.dart';
import '../config/titles/inventory_test_titles.dart';

class InventoryTestGroups {
  void groups(bool skipGroup) {
    group(
      InventoryTestTitles().REPO_TEST_TITLE,
      InventoryRepoTests.unit,
      skip: skipGroup, // 'skip-group' overrides the internal 'skip-methods'
    );

    group(
      InventoryTestTitles().SERVICE_TEST_TITLE,
      InventoryServiceTests.unit,
      skip: skipGroup,
    );

    group(
      InventoryTestTitles().CONTROLLER_TEST_TITLE,
      InventoryControllerTests.integration,
      skip: skipGroup,
    );

    group(
      "${InventoryTestTitles().VIEW_TEST_TITLE}",
      InventoryViewTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );

    group(
      InventoryTestTitles().VIEW_TEST_VALID_TITLE,
      InventoryViewValidationFunctionalTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );

    group(
      InventoryTestTitles().VIEW_EDIT_TEST_TITLE,
      InventoryViewEditTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}
