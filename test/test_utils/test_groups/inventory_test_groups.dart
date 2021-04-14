import 'package:test/test.dart';

import '../../app/modules/inventory/managed_products_controller_test.dart';
import '../../app/modules/inventory/pages/managed_product_add_edit_page_test'
    '.dart';
import '../../app/modules/inventory/pages/managed_products_page_test.dart';
import '../../app/modules/inventory/repo/managed_products_repo_test.dart';
import '../../app/modules/inventory/service/managed_products_service_test.dart';
import 'config.dart';

class InventoryTestGroups {
  static void groups() {
    group("$INVENTORY$INVENTORY_REPO", ManagedProductsRepoTest.unit);

    group("$INVENTORY$INVENTORY_SERVICE", ManagedProductsServiceTest.unit);

    group("$INVENTORY$INVENTORY_CONTROLLER",
        ManagedProductsControllerTest.integration);

    group("$INVENTORY$INVENTORY_VIEW", ManagedProductsPageTest.functional);

    group("$INVENTORY$INVENTORY_ADD_EDIT_VIEW",
        ManagedProductsAddEditPageTest.functional);
  }
}
