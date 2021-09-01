import 'package:flutter_test/flutter_test.dart';

import '../../app/core/components/drawwer_test.dart';
import '../../app/core/components/progres_indicator_test.dart';
import '../titles/components_test_titles.dart';

class ComponentsTestGroups {
  void groups({required skipGroup}) {
    group(
      ComponentsTestTitles().DRAWER_TITLE,
      DrawwerTest.functional,
      skip: skipGroup, // 'skip-group' overrides the internal 'skip-methods'
    );

    group(
      ComponentsTestTitles().PROGR_IND_TITLE,
      ProgresIndicatorTest.functional,
      skip: skipGroup,
    );
  }
}
