import 'package:test/test.dart';

import 'components_test_config.dart';
import 'drawwer_test.dart';
import 'progres_indicator_test.dart';

class ComponentsTestGroups {
  void groups() {
    group(
      "${ComponentsTestConfig().DRAWWER_TEST_TITLE}",
      DrawwerTest.functional,
    );

    group(
      "${ComponentsTestConfig().PROGR_IND_TEST_TITLE}",
      ProgresIndicatorTest.functional,
    );
  }
}
