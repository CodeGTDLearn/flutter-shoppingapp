import 'package:test/test.dart';

import 'inventory_controller_test.dart';
import 'inventory_test_config.dart';
import 'repo/inventory_repo_test.dart';
import 'service/inventory_service_test.dart';
import 'view/inventory_add_edit_page_test.dart';
import 'view/inventory_page_test.dart';

class InventoryTest {
  void groups() {
    group(
      "${InventoryTestConfig().REPO_TEST_TITLE}",
      InventoryRepoTests.unit,
    );
    group(
      "${InventoryTestConfig().SERVICE_TEST_TITLE}",
      InventoryServiceTests.unit,
    );
    group(
      "${InventoryTestConfig().CONTROLLER_TEST_TITLE}",
      InventoryControllerTests.integration,
    );
    group(
      "${InventoryTestConfig().VIEW_TEST_TITLE}",
      InventoryPageTests.functional,
    );
    group(
      "${InventoryTestConfig().VIEW_ADDEDIT_TEST_TITLE}",
      InventoryAddEditPageTests.functional,
    );
  }
}
