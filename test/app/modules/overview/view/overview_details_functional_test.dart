import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';

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
  var _products;

  OverviewDetailsTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(OverviewTests(
        testUtils: _utils,
        uiTestUtils: _uiUtils,
        dbTestUtils: _dbUtils,
        isWidgetTest: _isWidgetTest));

    setUpAll(
      () => _utils.globalSetUpAll('${_tests.runtimeType.toString()} - State Isolated'),
    );

    tearDownAll(() => _utils.globalTearDownAll(
          '${_tests.runtimeType.toString()} - State Isolated',
          _isWidgetTest,
        ));

    setUp(() async {
      _utils.globalSetUp;
      _products = await _utils.load_1Product_InDb(isWidgetTest: _isWidgetTest);
      _bindings.bindingsBuilderMockedRepo(isWidgetTest: _isWidgetTest);
    });

    tearDown(_utils.globalTearDown);

    testWidgets(_titles.click_product_check_details_texts, (tester) async {
      await _tests.check_product_details(
        tester,
        productButtonKey: "$OVERVIEW_GRID_ITEM_DETAILS_KEY\0",
        detailedProduct: _products[0],
      );
    });

    testWidgets(_titles.click_product_details_back_button, (tester) async {
      await _tests.tap_viewBackButton(
        tester,
        productButtonKey: "$OVERVIEW_GRID_ITEM_DETAILS_KEY\0",
      );
    });

    testWidgets(_titles.click_product_check_details_image, (tester) async {
      await _tests.check_product_details_image(
        tester,
        productButtonKey: "$OVERVIEW_GRID_ITEM_DETAILS_KEY\0",
        detailedProduct: _products[0],
      );
    });
  }
}
