import 'package:flutter_test/flutter_test.dart';

import '../../app/core/components/drawwer_test.dart';
import '../tests_properties.dart';
import '../titles/components_tests_drawwer_titles.dart';

class ComponentsTestGroupsDrawwer {
  void groups({required skipGroup}) {
    group(
      ComponentsTestsDrawwerTitles.GROUP_TITLE,
      DrawwerTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}
