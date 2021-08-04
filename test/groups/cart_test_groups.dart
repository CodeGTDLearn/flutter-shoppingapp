import 'package:flutter_test/flutter_test.dart';

import '../app/modules/cart/cart_controller_test.dart';
import '../app/modules/cart/cart_repo_test.dart';
import '../app/modules/cart/cart_service_test.dart';
import '../app/modules/cart/cart_view_functional_test.dart';
import '../config/cart_test_config.dart';

class CartTestGroups {
  void groups(bool skipGroup) {
    group(
      CartTestConfig().REPO_TEST_TITLE,
      CartRepoTests.unit,
      skip: skipGroup, // 'skip-group' overrides the internal 'skip-methods'
    );
    group(
      CartTestConfig().SERVICE_TEST_TITLE,
      CartServiceTests.unit,
      skip: skipGroup,
    );
    group(
      CartTestConfig().CONTROLLER_TEST_TITLE,
      CartControllerTests.integration,
      skip: skipGroup,
    );
    group(
      CartTestConfig().VIEW_TEST_TITLE,
      CartViewFunctionalTests.functional,
      skip: skipGroup,
    );
  }
}
