import 'package:test/test.dart';

import 'cart_controller_test.dart';
import 'cart_page_test.dart';
import 'cart_repo_test.dart';
import 'cart_service_test.dart';
import 'cart_test_config.dart';

class CartTestGroups {
  static void groups() {
    group("${CartTestConfig().CART_REPO}", CartRepoTest.unit);
    group("${CartTestConfig().CART_SERVICE}", CartServiceTest.unit);
    group("${CartTestConfig().CART_CONTROLLER}", CartControllerTest.integration);
    group("${CartTestConfig().CART_VIEW}", CartPageTest.functional);
  }
}
