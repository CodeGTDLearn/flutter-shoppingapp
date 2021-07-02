import 'package:test/test.dart';

import '../app/modules/cart/cart_controller_test.dart';
import '../app/modules/cart/cart_repo_test.dart';
import '../app/modules/cart/cart_service_test.dart';
import '../app/modules/cart/cart_view_test.dart';
import '../config/cart_test_config.dart';

class CartTestGroups {
  void groups() {
    group("${CartTestConfig().REPO_TEST_TITLE}", CartRepoTests.unit);
    group("${CartTestConfig().SERVICE_TEST_TITLE}", CartServiceTests.unit);
    group("${CartTestConfig().CONTROLLER_TEST_TITLE}", CartControllerTests.integration);
    group("${CartTestConfig().VIEW_TEST_TITLE}", CartViewTests.functional);
  }
}
