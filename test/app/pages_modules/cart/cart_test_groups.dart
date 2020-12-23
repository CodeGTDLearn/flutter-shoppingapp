import 'package:test/test.dart';

import 'cart_controller_test.dart';
import 'cart_page_test.dart';
import 'cart_repo_test.dart';
import 'cart_service_test.dart';

class CartModuleTest {
  static void groups() {
    const MODULE = 'Cart|';

    group("$MODULE\Repo: Unit", CartRepoTest.unit);

    group("$MODULE\Service|Repo: Unit", CartServiceTest.unit);

    group("$MODULE\Controller|Service|Repo: Integr",
        CartControllerTest.integration);

    group("$MODULE\View: Functional",
        CartPageTest.functional);
  }
}
