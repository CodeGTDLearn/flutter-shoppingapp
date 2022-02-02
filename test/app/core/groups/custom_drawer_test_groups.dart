import 'package:flutter_test/flutter_test.dart';

import '../../../config/app_tests_properties.dart';
import '../global_widgets/custom_drawer_test.dart';
import '../test_titles/custom_drawer_test_titles.dart';

class CustomDrawerTestGroups {
  void groups({required skipGroup}) {
    group(
      CustomDrawerTestTitles.GROUP_TITLE,
      CustomDrawerTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}