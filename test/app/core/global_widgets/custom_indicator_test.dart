import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../../config/app_tests_properties.dart';
import '../../../config/titles/custom_indicator_test_titles.dart';
import '../../../utils/finder_utils.dart';
import '../../../utils/tests_global_utils.dart';
import '../../../utils/tests_utils.dart';
import '../../../utils/ui_test_utils.dart';
import '../bindings/custom_widgets_test_bindings.dart';
import 'custom_indicator_tests.dart';

class CustomIndicatorTest {
  late bool _isWidgetTest;
  final _finder = Get.put(FinderUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _bindings = Get.put(CustomWidgetsTestBindings());
  final _titles = Get.put(CustomIndicatorTestTitles());
  final _testUtils = Get.put(TestsUtils());
  final _globalUtils = Get.put(TestsGlobalUtils());

  CustomIndicatorTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(CustomIndicatorTests(
        finder: _finder,
        uiTestUtils: _uiUtils,
        isWidgetTest: _isWidgetTest,
        testUtils: _testUtils));

    setUpAll(() async {
      _globalUtils.globalSetUpAll(
          testModuleName:
              '${_tests.runtimeType.toString()} $SHARED_STATE_TITLE');

      _bindings.bindingsBuilder(isWidgetTest: _isWidgetTest, isEmptyDb: false);
    });

    setUp(_globalUtils.globalSetUp);

    tearDown(_globalUtils.globalTearDown);

    testWidgets(_titles.check_custom_indicator, (tester) async {
      await _tests.check_custom_progr_indic(tester);
    });

    testWidgets(_titles.check_custom_indicator_emptydb, (tester) async {
      _bindings.bindingsBuilder(isWidgetTest: true, isEmptyDb: true);
      await _tests.check_custom_indicator_emptydb(tester);
    });
  }
}