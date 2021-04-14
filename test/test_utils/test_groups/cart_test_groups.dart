import 'package:test/test.dart';

import '../../app/modules/cart/cart_controller_test.dart';
import '../../app/modules/cart/cart_page_test.dart';
import '../../app/modules/cart/cart_repo_test.dart';
import '../../app/modules/cart/cart_service_test.dart';
import 'config.dart';

class CartTestGroups {
  static void groups() {
    group("$CART$CART_REPO", CartRepoTest.unit);

    group("$CART$CART_SERVICE", CartServiceTest.unit);

    group("$CART$CART_CONTROLLER", CartControllerTest.integration);

    group("$CART$CART_VIEW", CartPageTest.functional);
  }
}
