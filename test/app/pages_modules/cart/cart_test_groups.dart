import 'package:test/test.dart';

import 'cart_controller_test.dart';
import 'cart_repo_test.dart';
import 'cart_service_test.dart';

class CartModuleTest{
  static void groups() {
    const CART_MODULE_PAGE = 'Cart|';
    group("$CART_MODULE_PAGE\Repo: Unit", CartRepoTest.unit);
    group("$CART_MODULE_PAGE\Service|Repo: Unit", CartServiceTest.unit);
    group(
      "$CART_MODULE_PAGE\Controller|Service|Repo: Integr",
      CartControllerTest.integration,
    );
  }
}