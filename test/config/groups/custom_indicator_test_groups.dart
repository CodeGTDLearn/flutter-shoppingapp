import 'package:flutter_test/flutter_test.dart';

import '../../app/core/custom_widgets/custom_indicator_test.dart';
import '../app_tests_properties.dart';
import '../titles/custom_indicator_test_titles.dart';

class CustomIndicatorTestGroups {
  void groups({required skipGroup}) {
    group(
      CustomIndicatorTestTitles.GROUP_TITLE,
      CustomIndicatorTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}