import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';

import '../../../config/bindings/components_test_bindings.dart';
import '../../../config/tests_properties.dart';
import '../../../config/titles/components_tests_titles.dart';
import '../../../datasource/mocked_datasource.dart';
import '../../../utils/dbtest_utils.dart';
import '../../../utils/finder_utils.dart';
import '../../../utils/tests_global_utils.dart';
import '../../../utils/tests_utils.dart';
import '../../../utils/ui_test_utils.dart';
import 'drawwer_tests.dart';

class DrawwerTest {
  late bool _isWidgetTest;
  final _finder = Get.put(FinderUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());

  // final _bindings = Get.put(OverviewTestBindings());
  final _bindings = Get.put(ComponentsTestBindings());
  final _titles = Get.put(ComponentsTestsTitles());
  final _testUtils = Get.put(TestsUtils());
  final _globalMethods = Get.put(TestsGlobalUtils());

  DrawwerTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    var _products = <dynamic>[];
    final _tests = Get.put(DrawwerTests(
        finder: _finder,
        dbTestUtils: _dbUtils,
        uiTestUtils: _uiUtils,
        isWidgetTest: _isWidgetTest,
        testUtils: _testUtils));

    setUpAll(() async {
      _globalMethods.globalSetUpAll(
          testModuleName: '${_tests.runtimeType.toString()} $SHARED_STATE_TITLE');

      _products = _isWidgetTest
          ? await Future.value(MockedDatasource().products())
          : await _dbUtils.getCollection(url: PRODUCTS_URL);

      _bindings.bindingsBuilder(isWidgetTest: _isWidgetTest, isEmptyDb: false);
    });

    tearDownAll(() => _globalMethods.globalTearDownAll(
          testModuleName: _tests.runtimeType.toString(),
          isWidgetTest: _isWidgetTest,
        ));

    tearDownAll(() {
      _globalMethods.globalTearDownAll(
        testModuleName: _tests.runtimeType.toString(),
        isWidgetTest: _isWidgetTest,
      );
    });

    setUp(_globalMethods.globalSetUp);

    tearDown(_globalMethods.globalTearDown);

    testWidgets(_titles.open_and_close_drawer, (tester) async {
      await _tests.open_and_close_drawer(tester);
    });

    testWidgets(
      _titles.tap_two_different_options_in_drawer,
      (tester) async {
        await _tests.tap_twoDifferent_options_InDrawer(tester);
      },
      skip: true,
    );
  }
}
