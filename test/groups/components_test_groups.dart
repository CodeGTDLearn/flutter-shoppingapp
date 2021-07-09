import 'package:test/test.dart';

import '../app/core/components/drawwer_test.dart';
import '../app/core/components/progres_indicator_test.dart';
import '../config/components_test_config.dart';

class ComponentsTestGroups {
  void groups(bool skipGroup) {
    group(
      ComponentsTestConfig().DRAWWER_TEST_TITLE,
      DrawwerTest.functional,
      skip: skipGroup, // 'skip-group' overrides the internal 'skip-methods'
    );

    group(
      ComponentsTestConfig().PROGR_IND_TEST_TITLE,
      ProgresIndicatorTest.functional,
      skip: skipGroup,
    );
  }
}
