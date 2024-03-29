import 'package:flutter_test/flutter_test.dart';

import '../../../../config/app_tests_properties.dart';
import '../inventory_controller_test.dart';
import '../inventory_service_test.dart';
import '../repo/inventory_repo_test.dart';
import '../view/inventory_view_edit_test.dart';
import '../view/inventory_view_test.dart';
import '../view/inventory_view_validation_test.dart';
import 'inventory_test_titles.dart';

class InventoryTestGroups {
  void groups({required bool skipGroup}) {
    group(
      InventoryTestTitles().REPO_TITLE,
      InventoryRepoTests().unit,
      skip: skipGroup, // 'skip-group' overrides the internal 'skip-methods'
    );

    group(
      InventoryTestTitles().SERVICE_TITLE,
      InventoryServiceTests().unit,
      skip: skipGroup,
    );

    group(
      InventoryTestTitles().CONTROLLER_TITLE,
      InventoryControllerTests().integration,
      skip: skipGroup,
    );

    group(
      "${InventoryTestTitles().VIEW_TITLE}",
      InventoryViewTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );

    group(
      InventoryTestTitles().VIEW_VALID_TITLE,
      InventoryViewValidationTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );

    group(
      InventoryTestTitles().VIEW_EDIT_TITLE,
      InventoryViewEditTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}