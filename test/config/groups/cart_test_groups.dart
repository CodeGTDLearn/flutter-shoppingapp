import 'package:flutter_test/flutter_test.dart';

import '../../app/modules/cart/cart_controller_test.dart';
import '../../app/modules/cart/cart_repo_test.dart';
import '../../app/modules/cart/cart_service_test.dart';
import '../../app/modules/cart/view/cart_view_test.dart';
import '../app_tests_properties.dart';
import '../titles/cart_test_titles.dart';

class CartTestGroups {
  void groups({required bool skipGroup}) {
    group(
      CartTestTitles().REPO_TITLE,
      CartRepoTests().unit,
      skip: skipGroup, // 'skip-group' overrides the internal 'skip-methods'
    );

    group(
      CartTestTitles().SERVICE_TITLE,
      CartServiceTests().unit,
      skip: skipGroup,
    );

    group(
      CartTestTitles().CONTROLLER_TITLE,
      CartControllerTests().integration,
      skip: skipGroup,
    );

    group(
      CartTestTitles().VIEW_TITLE,
      CartViewTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}