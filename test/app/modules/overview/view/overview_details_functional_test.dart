import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import '../../../../config/app_tests_config.dart';
import '../../../../config/overview_test_config.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'overview_tests.dart';

class OverviewDetailsTest {
  late bool _isWidgetTest;
  final TestUtils _utils = Get.put(TestUtils());
  final UiTestUtils _uiUtils = Get.put(UiTestUtils());
  final DbTestUtils _dbUtils = Get.put(DbTestUtils());
  final OverviewTestConfig _config = Get.put(OverviewTestConfig());

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
      _utils.globalSetUp("Starting...");
      _config.bindingsBuilderMockedRepo(isWidgetTest: _isWidgetTest);
    });

    tearDown(() => _utils.globalTearDown("...Ending"));

    testWidgets(_config.click_product_check_details_texts, (tester) async {
      await _tests.clickProductCheckDetailsText(tester);
    });

    testWidgets(_config.click_product_check_details_image, (tester) async {
      await _tests.clickProductCheckDetailsImage(tester);
    });
  }
}
