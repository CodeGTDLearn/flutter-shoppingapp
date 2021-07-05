import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';

import '../../../../config/app_tests_config.dart';
import '../../../../config/overview_test_config.dart';
import '../../../../data_builders/product_databuilder.dart';
import '../../../../mocked_datasource/products_mocked_datasource.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'overview_tests.dart';

class OverviewViewTest {
  bool _isWidgetTest;
  final bool _skipTest = false;
  final TestUtils _utils = Get.put(TestUtils());
  final UiTestUtils _uiUtils = Get.put(UiTestUtils());
  final DbTestUtils _dbUtils = Get.put(DbTestUtils());
  final OverviewTestConfig _config = Get.put(OverviewTestConfig());

  OverviewViewTest({String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(OverviewTests(
      testUtils: _utils,
      dbTestUtils: _dbUtils,
      uiTestUtils: _uiUtils,
      isWidgetTest: _isWidgetTest,
    ));

    setUpAll(() => _utils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _utils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _utils.globalSetUp("Starting...");
      _config.bindingsBuilder();
    });

    tearDown(() => _utils.globalTearDown("...Ending"));

    testWidgets('${_config.check_products}', (tester) async {
      await _tests.checkProducts(tester);
    }, skip: _skipTest);

    testWidgets('${_config.toggle_favorite_status}', (tester) async {
      await _tests.toggleFavoriteStatus(tester);
      // @formatter:on
    }, skip: _skipTest);

    testWidgets('${_config.add_prod_snackbar}', (tester) async {
      await _tests.addProductCheckSnackbar(tester);
    }, skip: _skipTest);

    testWidgets('${_config.add_prod_snackbar_undo}', (tester) async {
      await _tests.addProductAndClickUndoInSnackbar(tester);
    }, skip: _skipTest);

    testWidgets('${_config.add_prod1_3x_check_shopCartIcon}', (tester) async {
      await _tests.addProduct1ThreeTimesAndCheckShopCartIcon(tester);
    }, skip: _skipTest);

    testWidgets('${_config.add_prods1And2_check_shopCartIcon}', (tester) async {
      await _tests.addProducts1And2AndCheckShopcarticon(tester);
    }, skip: _skipTest);

    testWidgets('${_config.add_prods3And4_check_shopCartIcon}', (tester) async {
      await _tests.addProducts3And4AndCheckShopcarticon(tester);
    }, skip: _skipTest);

    testWidgets('${_config.tap_fav_filter_no_favorites_found}', (tester) async {
      await _tests.tapFavoritesFilterNoFavoritesFound(tester);
    }, skip: _skipTest);

    testWidgets('${_config.tap_fav_filter}', (tester) async {
      await _tests.tapFavoriteFilter(tester);
    }, skip: _skipTest);

    testWidgets('${_config.close_fav_filter}', (tester) async {
      await _tests.closeFavoriteFilter(tester);
    }, skip: _skipTest);
  }
}
