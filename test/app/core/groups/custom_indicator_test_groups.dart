import 'package:flutter_test/flutter_test.dart';

import '../../../config/app_tests_properties.dart';
import '../global_widgets/custom_indicator_test.dart';
import '../test_titles/custom_indicator_test_titles.dart';

class CustomIndicatorTestGroups {
  void groups({required skipGroup}) {
    group(
      CustomIndicatorTestTitles.GROUP_TITLE,
      CustomIndicatorTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}