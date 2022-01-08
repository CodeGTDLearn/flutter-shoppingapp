import 'package:flutter_test/flutter_test.dart';

import '../../app/core/global_widgets/custom_drawer_test.dart';
import '../app_tests_properties.dart';
import '../titles/custom_drawer_test_titles.dart';

class CustomDrawerTestGroups {
  void groups({required skipGroup}) {
    group(
      CustomDrawerTestTitles.GROUP_TITLE,
      CustomDrawerTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}