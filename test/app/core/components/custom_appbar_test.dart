import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../../../config/bindings/custom_components_test_bindings.dart';
import '../../../config/tests_properties.dart';
import '../../../config/titles/custom_appbar_test_titles.dart';
import '../../../utils/finder_utils.dart';
import '../../../utils/tests_global_utils.dart';
import '../../../utils/tests_utils.dart';
import '../../../utils/ui_test_utils.dart';
import 'custom_appbar_tests.dart';

class CustomAppbarTest {
  late bool _isWidgetTest;
  final _finder = Get.put(FinderUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _bindings = Get.put(CustomComponentsTestBindings());
  final _titles = Get.put(CustomAppbarTestTitles());
  final _testUtils = Get.put(TestsUtils());
  final _globalUtils = Get.put(TestsGlobalUtils());

  CustomAppbarTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(CustomAppbarTests(
        finder: _finder,
        uiTestUtils: _uiUtils,
        isWidgetTest: _isWidgetTest,
        testUtils: _testUtils));

    setUpAll(() async {
      _globalUtils.globalSetUpAll(
          testModuleName: '${_tests.runtimeType.toString()} $SHARED_STATE_TITLE');

      // _bindings.bindingsBuilder(isWidgetTest: _isWidgetTest, isEmptyDb: false);
    });

    tearDownAll(() {
      _globalUtils.globalTearDownAll(
        testModuleName: _tests.runtimeType.toString(),
        isWidgetTest: _isWidgetTest,
      );
    });

    setUp(() {
      _globalUtils.globalSetUp();
      _bindings.bindingsBuilder(isWidgetTest: _isWidgetTest, isEmptyDb: false);
    });

    tearDown(_globalUtils.globalTearDown);

    testWidgets(_titles.close_favFilterPopup_tapOutside, (tester) async {
      await _tests.close_favoritesFilter_popup_tapOutside(tester);
    });

    testWidgets(_titles.check_popup_menuitem_enabled_favorites, (tester) async {
      await _tests.check_popup_menuitem_enabled_favorites(tester);
    });

    testWidgets(_titles.check_popup_menuitem_enabled_all, (tester) async {
      await _tests.check_popup_menuitem_enabled_all(tester);
    });

    // testWidgets(_titles.tap_favFilter_noFavoritesFound, (tester) async {
    //   await _tests.tap_FavoritesFilter_NoFavoritesFound(tester);
    // });
  }
}