import 'package:shopingapp/app/modules/orders/repo/i_orders_repo.dart';

import 'repo/orders_repo_mocks.dart';

class OrdersTestConfig {
//REPO-USED-IN-THIS-TEST-MODULE:
  final IOrdersRepo _repository_to_be_used_in_all_orders_modules_tests =
      OrdersMockRepo();

//TEST-GROUPS-TITLES:
  final ORDER_REPO = 'Orders|Repo: Unit';
  final ORDER_SERVICE = 'Orders|Service|Repo: Unit';
  final ORDER_CONTROLLER = 'Orders|Controller|Service|Repo: Integr';
  final ORDER_VIEW = 'Orders|View: Functional';

  IOrdersRepo get testsRepo =>
      _repository_to_be_used_in_all_orders_modules_tests;
}
