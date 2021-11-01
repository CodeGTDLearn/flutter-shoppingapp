import 'package:flutter_test/flutter_test.dart';

import '../../app/core/components/custom_indicator_test.dart';
import '../tests_properties.dart';
import '../titles/components_tests_progres_indic_titles.dart';

class ComponentsTestGroupsProgresIndicator {
  void groups({required skipGroup}) {
    group(
      ComponentsTestsProgresIndicTitles.GROUP_TITLE,
      CustomIndicatorTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}
