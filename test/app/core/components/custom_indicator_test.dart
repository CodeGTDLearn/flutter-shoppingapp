import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../../../config/bindings/components_test_bindings.dart';
import '../../../config/tests_properties.dart';
import '../../../config/titles/components_tests_progres_indic_titles.dart';
import '../../../utils/finder_utils.dart';
import '../../../utils/tests_global_utils.dart';
import '../../../utils/tests_utils.dart';
import '../../../utils/ui_test_utils.dart';
import 'custom_indicator_tests.dart';

class CustomIndicatorTest {
  late bool _isWidgetTest;
  final _finder = Get.put(FinderUtils());
  final _uiUtils = Get.put(UiTestUtils());

  final _bindings = Get.put(ComponentsTestBindings());
  final _titles = Get.put(ComponentsTestsProgresIndicTitles());
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
          testModuleName: '${_tests.runtimeType.toString()} $SHARED_STATE_TITLE');

      _bindings.bindingsBuilder(isWidgetTest: _isWidgetTest, isEmptyDb: false);
    });

    setUp(_globalUtils.globalSetUp);

    tearDown(_globalUtils.globalTearDown);

    testWidgets(_titles.check_custom_progr_indic, (tester) async {
      await _tests.check_custom_progr_indic(tester);
    });

    testWidgets(_titles.check_custom_progr_indic_emptydb, (tester) async {
      ComponentsTestBindings().bindingsBuilder(isWidgetTest: true, isEmptyDb: true);
      await _tests.check_custom_progr_indic_emptydb(tester);
    });
  }
}
