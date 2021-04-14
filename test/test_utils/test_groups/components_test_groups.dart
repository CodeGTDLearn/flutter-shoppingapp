import 'package:test/test.dart';

import '../../app/modules/components/drawwer_test.dart';
import '../../app/modules/components/progres_indicator_test.dart';
import 'config.dart';

class ComponentsTestGroups {
  static void groups() {
    group(
      "$COMPONENTS$COMPONENTS_DRAWER",
      DrawwerTest.functional,
    );

    group(
      "$COMPONENTS$COMPONENTS_PROGRESS_INDICATOR",
      ProgresIndicatorTest.functional,
    );
  }
}
