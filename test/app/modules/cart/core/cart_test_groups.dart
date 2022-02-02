import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../../../config/app_tests_properties.dart';
import '../cart_controller_test.dart';
import '../cart_repo_test.dart';
import '../cart_service_test.dart';
import '../view/cart_view_test.dart';
import 'cart_test_titles.dart';

class CartTestGroups {
  final _titles = Get.put(CartTestTitles());

  void groups({required bool skipGroup}) {
    group(
      _titles.REPO_TITLE,
      CartRepoTests().unit,
      skip: skipGroup, // 'skip-group' overrides the internal 'skip-methods'
    );

    group(
      _titles.SERVICE_TITLE,
      CartServiceTests().unit,
      skip: skipGroup,
    );

    group(
      _titles.CONTROLLER_TITLE,
      CartControllerTests().integration,
      skip: skipGroup,
    );

    group(
      _titles.VIEW_TITLE,
      CartViewTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}