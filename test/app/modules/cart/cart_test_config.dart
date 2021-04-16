import 'package:shopingapp/app/modules/cart/repo/cart_repo.dart';
import 'package:shopingapp/app/modules/cart/repo/i_cart_repo.dart';

class CartTestConfig {
//REPO-USED-IN-THIS-TEST-MODULE:
  final ICartRepo _repository_to_be_used_in_all_cart_modules_tests = CartRepo();

//TEST-GROUPS-TITLES:
  final CART_REPO = 'Cart|Repo: Unit';
  final CART_SERVICE = 'Cart|Service|Repo: Unit';
  final CART_CONTROLLER = 'Cart|Controller|Service|Repo: Integr';
  final CART_VIEW = 'Cart|View: Functional';

  ICartRepo get testsRepo => _repository_to_be_used_in_all_cart_modules_tests;
}
