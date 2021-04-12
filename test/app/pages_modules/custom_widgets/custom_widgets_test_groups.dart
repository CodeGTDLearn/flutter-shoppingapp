import 'package:test/test.dart';

import 'custom_drawer_test.dart';
import 'custom_progress_indicator_test.dart';

class CustomWidgetsModuleTest {
  static void groups() {
    const MODULE = 'Custom Widgets|';

    group(
      "$MODULE\View|Custom Drawer: Functional",
      CustomDrawerTest.functional,
    );

    group(
      "$MODULE\View|CustomProgressIndicator: Functional",
      CustomProgressIndicatorTest.functional,
    );
  }
}
