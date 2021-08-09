import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../../../../config/bindings/overview_test_bindings.dart';
import '../../../../config/tests_config.dart';
import '../../../../config/titles/overview_test_titles.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'overview_tests.dart';

class OverviewDetailsTest {
  late bool _isWidgetTest;
  final _utils = Get.put(TestUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());
  final _bindings = Get.put(OverviewTestBindings());
  final _titles = Get.put(OverviewTestTitles());

  OverviewDetailsTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(OverviewTests(
        testUtils: _utils,
        uiTestUtils: _uiUtils,
        dbTestUtils: _dbUtils,
        isWidgetTest: _isWidgetTest));

    setUpAll(() async => _utils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _utils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _utils.globalSetUp("Starting Test...");
      _bindings.bindingsBuilderMockedRepo(isWidgetTest: _isWidgetTest);
    });

    tearDown(() => _utils.globalTearDown("...Ending Test"));

    testWidgets(_titles.click_product_check_details_texts, (tester) async {
      await _tests.clickProductCheckDetailsText(tester);
    });

    testWidgets(_titles.click_product_check_details_image, (tester) async {
      await _tests.clickProductCheckDetailsImage(tester);
    });
  }
}
