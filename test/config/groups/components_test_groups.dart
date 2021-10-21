import 'package:flutter_test/flutter_test.dart';

import '../../app/core/components/drawwer_test.dart';
import '../../app/core/components/progres_indicator_test.dart';
import '../tests_properties.dart';
import '../titles/components_tests_titles.dart';

class ComponentsTestGroups {
  void groups({required skipGroup}) {
    group(
      ComponentsTestsTitles.GROUP_TITLE_PROGR_INDIC,
      ProgresIndicatorTest().functional,
      skip: skipGroup,
    );

    group(
      ComponentsTestsTitles.GROUP_TITLE_DRAWWER,
      DrawwerTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}
