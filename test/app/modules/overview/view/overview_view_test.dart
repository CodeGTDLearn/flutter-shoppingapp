import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/components/core_components_keys.dart';
import 'package:shopingapp/app/core/properties/db_urls.dart';
import 'package:shopingapp/app/modules/overview/core/overview_keys.dart';

import '../../../../config/app_tests_properties.dart';
import '../../../../config/datasource/mocked_datasource.dart';
import '../../../../config/utils/finder_utils.dart';
import '../../../../config/utils/testdb_utils.dart';
import '../../../../config/utils/tests_global_utils.dart';
import '../../../../config/utils/tests_utils.dart';
import '../../../../config/utils/ui_test_utils.dart';
import '../core/overview_test_bindings.dart';
import '../core/overview_test_titles.dart';
import 'overview_tests.dart';

class OverviewViewTest {
  late bool _isWidgetTest;
  final _finder = Get.put(FinderUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(TestDbUtils());
  final _bindings = Get.put(OverviewTestBindings());
  final _titles = Get.put(OverviewTestTitles());
  final _testUtils = Get.put(TestsUtils());
  final _globalUtils = Get.put(TestsGlobalUtils());
  final _keys = Get.find<OverviewKeys>();
  final _keysSnack = Get.find<CoreComponentsKeys>();

  OverviewViewTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    var _products = <dynamic>[];

    final _tests = Get.put(OverviewTests(
        finder: _finder,
        dbTestUtils: _dbUtils,
        uiTestUtils: _uiUtils,
        isWidgetTest: _isWidgetTest,
        testUtils: _testUtils));

    setUpAll(() async {
      _globalUtils.globalSetUpAll(
          testModuleName: '${_tests.runtimeType.toString()} $SHARED_STATE_TITLE');
    });

    tearDownAll(() => _globalUtils.globalTearDownAll(
          testModuleName: _tests.runtimeType.toString(),
          isWidgetTest: _isWidgetTest,
        ));

    setUp(() async {
      _globalUtils.globalSetUp();

      _products = _isWidgetTest
          ? await Future.value(MockedDatasource().products())
          : await _dbUtils.getCollection(url: PRODUCTS_URL);

      _products.toString();

      _bindings.bindingsBuilder(isWidgetTest: _isWidgetTest, isEmptyDb: false);
    });

    tearDown(_globalUtils.globalTearDown);

    testWidgets(_titles.check_overviewGridItems_qtde, (tester) async {
      await _tests.check_overviewGridItems_qtde(
        tester,
        qtde: _products.length,
      );
    });

    testWidgets(_titles.toggle_favoriteButton_in_overviewGridItem, (tester) async {
      await _tests.toggle_favoriteButton_in_overviewGridItem(
        tester,
        toggleButtonKey: "${_keys.k_ov_grd_fav_btn}\0",
        totalProducts: _products.length,
      );
    });

    testWidgets(_titles.add_sameProduct2x_check_shopCartIcon, (tester) async {
      await _tests.add_sameProduct2x_check_shopCartIcon(
        tester,
        productTitle: _products.elementAt(0).title,
        qtdeToAdded: 2,
      );
    });

    testWidgets(_titles.add_product_click_undoSnackbar_check_shopCartIcon,
        (tester) async {
      await _tests.add_product_click_undoSnackbar_check_shopCartIcon(
        tester,
        addProductButtonKey: "${_keys.k_ov_grd_crt_btn}\0",
        productTitle: _products.elementAt(0).title,
        snackbarUndoButtonKey: _keysSnack.k_snackbar_btn(),
      );
    });

    testWidgets(_titles.add_sameProduct3x_check_shopCartIcon, (tester) async {
      await _tests.add_sameProduct3x_check_shopCartIcon(
        tester,
        productAddButtonKey: "${_keys.k_ov_grd_crt_btn}\0",
        qtdeToAdded: 3,
      );
    });

    testWidgets(_titles.add_allProducts_check_shopCartIcon, (tester) async {
      await _tests.add_allProducts_check_shopCartIcon(
        tester,
        qtdeToAdded: _products.length,
      );
    });

    testWidgets(_titles.tap_product_details_check_texts, (tester) async {
      await _tests.check_product_details_backbutton_overview(
        tester,
        productButtonKey: "${_keys.k_ov_grd_crt_btn}\1",
        detailedProduct: _products.elementAt(1),
      );
    });

    testWidgets(_titles.tap_product_details_check_image, (tester) async {
      await _tests.check_product_details_image_backbutton_overview(
        tester,
        productButtonKey: "${_keys.k_ov_grd_crt_btn}\0",
        detailedProduct: _products.elementAt(0),
      );
    });
  }
}