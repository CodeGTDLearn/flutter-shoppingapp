import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../../config/tests_properties.dart';
import '../../../config/titles/custom_drawer_test_titles.dart';
import '../../../utils/finder_utils.dart';
import '../../../utils/tests_global_utils.dart';
import '../../../utils/tests_utils.dart';
import '../../../utils/ui_test_utils.dart';
import 'custom_drawer_tests.dart';
import 'custom_widgets_test_bindings.dart';

class CustomDrawerTest {
  late bool _isWidgetTest;
  final _finder = Get.put(FinderUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _bindings = Get.put(CustomWidgetsTestBindings());
  final _titles = Get.put(CustomDrawerTestTitles());
  final _testUtils = Get.put(TestsUtils());
  final _globalUtils = Get.put(TestsGlobalUtils());

  CustomDrawerTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(CustomDrawerTests(
        finder: _finder,
        uiTestUtils: _uiUtils,
        isWidgetTest: _isWidgetTest,
        testUtils: _testUtils));

    setUpAll(() async {
      _globalUtils.globalSetUpAll(
          testModuleName: '${_tests.runtimeType.toString()} $SHARED_STATE_TITLE');

      _bindings.bindingsBuilder(isWidgetTest: _isWidgetTest, isEmptyDb: false);
    });

    tearDownAll(() {
      _globalUtils.globalTearDownAll(
        testModuleName: _tests.runtimeType.toString(),
        isWidgetTest: _isWidgetTest,
      );
    });

    setUp(_globalUtils.globalSetUp);

    tearDown(_globalUtils.globalTearDown);

    testWidgets(_titles.tap_two_different_options_in_drawer, (tester) async {
      await _tests.tap_two_different_options_in_drawer(tester);
    });

    testWidgets(_titles.close_drawer_tap_outside, (tester) async {
      await _tests.close_drawer_tap_outside(tester);
    });

    testWidgets(_titles.tap_drawer_darkmode_option, (tester) async {
      await _tests.tap_drawer_darkmode_option(tester);
    });
  }
}