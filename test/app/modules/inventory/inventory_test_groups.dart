import 'package:test/test.dart';

import 'inventory_controller_test.dart';
import 'inventory_test_config.dart';
import 'pages/inventory_add_edit_page_test.dart';
import 'pages/inventory_page_test.dart';
import 'repo/inventory_repo_test.dart';
import 'service/inventory_service_test.dart';

class InventoryTestGroups {
  static void groups() {
    group(
      "${InventoryTestConfig().INVENTORY_REPO}",
      InventoryRepoTest.unit,
    );
    group(
      "${InventoryTestConfig().INVENTORY_SERVICE}",
      InventoryServiceTest.unit,
    );
    group(
      "${InventoryTestConfig().INVENTORY_CONTROLLER}",
      InventoryControllerTest.integration,
    );
    group(
      "${InventoryTestConfig().INVENTORY_VIEW}",
      InventoryPageTest.functional,
    );
    group(
      "${InventoryTestConfig().INVENTORY_DETAIL_VIEW}",
      InventoryAddEditPageTest.functional,
    );
  }
}
