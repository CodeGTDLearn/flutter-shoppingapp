import 'package:shopingapp/app/modules/inventory/repo/i_inventory_repo.dart';

import 'repo/inventory_repo_mocks.dart';

class InventoryTestConfig {
//REPO-USED-IN-THIS-TEST-MODULE:
  final IInventoryRepo _repository_to_be_used_in_all_Inventory_modules_tests =
      InventoryMockRepo();

//TEST-GROUPS-TITLES:
  final INVENTORY_REPO = 'Inventory|Repo: Unit';
  final INVENTORY_SERVICE = 'Inventory|Service|Repo: Unit';
  final INVENTORY_CONTROLLER = 'Inventory|Controller|Service|Repo: Integr';
  final INVENTORY_VIEW = 'Inventory|View|Page: Functional';
  final INVENTORY_DETAIL_VIEW = 'Inventory|View|Add/Edit Page: Functional';

  IInventoryRepo get testsRepo =>
      _repository_to_be_used_in_all_Inventory_modules_tests;
}
