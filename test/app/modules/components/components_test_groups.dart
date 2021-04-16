import 'package:test/test.dart';

import 'components_test_config.dart';
import 'drawwer_test.dart';
import 'progres_indicator_test.dart';

class ComponentsTestGroups {
  static void groups() {
    group(
      "${ComponentsTestConfig().COMPONENTS_DRAWER}",
      DrawwerTest.functional,
    );

    group(
      "${ComponentsTestConfig().COMPONENTS_PROGRESS_INDICATOR}",
      ProgresIndicatorTest.functional,
    );
  }
}
