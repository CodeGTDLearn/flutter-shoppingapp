import 'package:flutter_test/flutter_test.dart';

import '../../app/modules/cart/cart_controller_test.dart';
import '../../app/modules/cart/cart_repo_test.dart';
import '../../app/modules/cart/cart_service_test.dart';
import '../../app/modules/cart/view/cart_view_test.dart';
import '../tests_properties.dart';
import '../titles/cart_tests_titles.dart';

class CartTestGroups {
  void groups({required bool skipGroup}) {
    group(
      CartTestsTitles().REPO_TITLE,
      CartRepoTests().unit,
      skip: skipGroup, // 'skip-group' overrides the internal 'skip-methods'
    );

    group(
      CartTestsTitles().SERVICE_TITLE,
      CartServiceTests().unit,
      skip: skipGroup,
    );

    group(
      CartTestsTitles().CONTROLLER_TITLE,
      CartControllerTests().integration,
      skip: skipGroup,
    );

    group(
      CartTestsTitles().VIEW_TITLE,
      CartViewTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}
