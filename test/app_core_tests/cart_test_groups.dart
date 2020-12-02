import 'package:test/test.dart';

import '../app/pages_modules/cart/cart_controller_test.dart';
import '../app/pages_modules/cart/cart_repo_test.dart';
import '../app/pages_modules/cart/cart_service_test.dart';

class CartModuleTestGroups{
  static void groups() {
    const CART_MODULE_PAGE = 'Cart|';
    group("$CART_MODULE_PAGE\Repo: Unit", CartRepoTest.unitTests);
    group("$CART_MODULE_PAGE\Service|Repo: Unit", CartServiceTest.unitTests);
    group(
      "$CART_MODULE_PAGE\Controller|Service|Repo: Integr",
      CartControllerTest.integrationTests,
    );
  }
}