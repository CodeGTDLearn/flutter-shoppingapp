import 'package:test/test.dart';

import 'cart_controller_test.dart';
import 'cart_repo_test.dart';
import 'cart_service_test.dart';
import 'cart_test_config.dart';
import 'cart_view_test.dart';

class CartTest {
  static void groups() {
    group("${CartTestConfig().REPO_TEST_TITLE}", CartRepoTests.unit);
    group("${CartTestConfig().SERVICE_TEST_TITLE}", CartServiceTests.unit);
    group("${CartTestConfig().CONTROLLER_TEST_TITLE}", CartControllerTests.integration);
    group("${CartTestConfig().VIEW_TEST_TITLE}", CartViewTests.functional);
  }
}
