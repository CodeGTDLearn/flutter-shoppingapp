import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../../../config/bindings/components_test_bindings.dart';
import '../../../config/tests_properties.dart';
import '../../../config/titles/components_tests_titles.dart';
import '../../../utils/finder_utils.dart';
import '../../../utils/tests_global_utils.dart';
import '../../../utils/tests_utils.dart';
import '../../../utils/ui_test_utils.dart';
import 'progr_indicator_tests.dart';

class ProgrIndicatorTest {
  late bool _isWidgetTest;
  final _finder = Get.put(FinderUtils());
  final _uiUtils = Get.put(UiTestUtils());

  final _bindings = Get.put(ComponentsTestBindings());
  final _titles = Get.put(ComponentsTestsTitles());
  final _testUtils = Get.put(TestsUtils());
  final _globalMethods = Get.put(TestsGlobalUtils());

  ProgrIndicatorTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(ProgrIndicatorTests(
        finder: _finder,
        uiTestUtils: _uiUtils,
        isWidgetTest: _isWidgetTest,
        testUtils: _testUtils));

    // var _products = <dynamic>[];

    setUpAll(() async {
      _globalMethods.globalSetUpAll(
          testModuleName: '${_tests.runtimeType.toString()} $SHARED_STATE_TITLE');

      // _products = _isWidgetTest
      //     ? await Future.value(MockedDatasource().products())
      //     : await _dbUtils.getCollection(url: PRODUCTS_URL);

      _bindings.bindingsBuilder(isWidgetTest: _isWidgetTest, isEmptyDb: false);
    });

    setUp(_globalMethods.globalSetUp);

    tearDown(_globalMethods.globalTearDown);

    testWidgets(_titles.check_custom_progr_indic, (tester) async {
      await _tests.check_custom_progr_indic(tester);
    }, skip: false);

    testWidgets(_titles.check_custom_progr_indic_emptydb, (tester) async {
      ComponentsTestBindings().bindingsBuilder(isWidgetTest: true, isEmptyDb: true);
      await _tests.check_custom_progr_indic_emptydb(tester);
    }, skip: false);
  }
}
