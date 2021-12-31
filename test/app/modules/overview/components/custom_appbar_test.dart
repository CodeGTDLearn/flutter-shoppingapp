import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../../../../config/app_tests_properties.dart';
import '../../../../config/titles/custom_appbar_test_titles.dart';
import '../../../../utils/finder_utils.dart';
import '../../../../utils/tests_global_utils.dart';
import '../../../../utils/tests_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import '../../../core/bindings/custom_widgets_test_bindings.dart';
import 'custom_appbar_tests.dart';

class CustomAppbarTest {
  late bool _isWidgetTest;
  final _finder = Get.put(FinderUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _bindings = Get.put(CustomWidgetsTestBindings());
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

    testWidgets(_titles.tap_favoritesFilter_noFavoritesFound, (tester) async {
      _bindings.bindingsBuilder(isWidgetTest: _isWidgetTest, isEmptyDb: true);
      await _tests.tap_favoritesFilter_noFavoritesFound(tester);
    });

    testWidgets(_titles.tap_favoriteFilterPopup, (tester) async {
      await _tests.tap_favoriteFilterPopup(tester);
    });
  }
}