import 'package:flutter_test/flutter_test.dart';

import '../../app/modules/overview/core/custom_appbar_test.dart';
import '../app_tests_properties.dart';
import '../titles/custom_appbar_test_titles.dart';

class CustomAppbarTestGroups {
  void groups({required skipGroup}) {
    group(
      CustomAppbarTestTitles.GROUP_TITLE,
      CustomAppbarTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}