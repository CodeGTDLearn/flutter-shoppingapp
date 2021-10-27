import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/snackbarr_keys.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';

import '../../../../config/bindings/overview_test_bindings.dart';
import '../../../../config/tests_properties.dart';
import '../../../../config/titles/overview_tests_titles.dart';
import '../../../../datasource/mocked_datasource.dart';
import '../../../../utils/dbtest_utils.dart';
import '../../../../utils/finder_utils.dart';
import '../../../../utils/tests_global_utils.dart';
import '../../../../utils/tests_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'overview_tests.dart';

class OverviewViewTest {
  late bool _isWidgetTest;
  final _finder = Get.put(FinderUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());
  final _bindings = Get.put(OverviewTestBindings());
  final _titles = Get.put(OverviewTestsTitles());
  final _testUtils = Get.put(TestsUtils());
  final _globalMethods = Get.put(TestsGlobalUtils());

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
      _globalMethods.globalSetUpAll(
          testModuleName: '${_tests.runtimeType.toString()} $SHARED_STATE_TITLE');

      _products = _isWidgetTest
          ? await Future.value(MockedDatasource().products())
          : await _dbUtils.getCollection(url: PRODUCTS_URL);

      _bindings.bindingsBuilder(isWidgetTest: _isWidgetTest);
    });

    tearDownAll(() => _globalMethods.globalTearDownAll(
          testModuleName: _tests.runtimeType.toString(),
          isWidgetTest: _isWidgetTest,
        ));

    setUp(_globalMethods.globalSetUp);

    tearDown(_globalMethods.globalTearDown);

    testWidgets(_titles.check_overviewGridItems, (tester) async {
      await _tests.check_overviewGridItems_qtde(tester, qtde: _products.length);
    });

    testWidgets(_titles.toggle_ProductFavoriteButton, (tester) async {
      await _tests.toggle_ProductFavoriteButton(
        tester,
        toggleButtonKey: "$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\0",
      );
    });

    testWidgets(_titles.add_sameProduct2x_Check_ShopCartIcon, (tester) async {
      await _tests.add_identicalProduct2x_Check_ShopCartIcon(
        tester,
        addProductButtonKey: "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0",
        productTitle: _products.elementAt(0).title,
        totalBeforeAdding: 0,
        totalAfterAdding: 2,
      );
    });

    testWidgets(_titles.addProduct_click_undoSnackbar_check_shopCartIcon, (tester) async {
      await _tests.addProduct_click_UndoSnackbar_Check_ShopCartIcon(
        tester,
        addProductButtonKey: "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0",
        productTitle: _products.elementAt(0).title,
        snackbarUndoButtonKey: CUSTOM_SNACKBAR_BUTTON_KEY,
        total: 2,
      );
    });

    testWidgets(_titles.add_sameProduct3x_check_shopCartIcon, (tester) async {
      await _tests.add_identicalProduct3x_check_shopCartIcon(
        tester,
        productAddButtonKey: "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0",
        totalBeforeAdding: 2,
        totalAfterAdding: 5,
      );
    });

    testWidgets(_titles.add_AllDbProducts_check_shopCartIcon, (tester) async {
      await _tests.add_AllDbProducts_check_shopCartIcon(
        tester,
        firstProduct_addButtonKey: "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0",
        totalBeforeAdding: 5,
        totalAfterAdding: _products.length + 5,
      );
    });

    testWidgets(_titles.tap_favFilter_noFavoritesFound, (tester) async {
      await _tests.tap_FavoritesFilter_NoFavoritesFound(tester);
    });

    testWidgets(_titles.tap_favFilterPopup, (tester) async {
      await _tests.tap_FavoriteFilterPopup(tester);
    });

    testWidgets(_titles.close_favFilterPopup_tapOutside, (tester) async {
      await _tests.close_FavoriteFilterPopup(tester);
    });

    testWidgets(_titles.tap_product_details_check_texts, (tester) async {
      await _tests.check_product_details_backbutton_overview(
        tester,
        productButtonKey: "$OVERVIEW_GRID_ITEM_DETAILS_KEY\1",
        detailedProduct: _products.elementAt(1),
      );
    });

    testWidgets(_titles.tap_product_details_check_image, (tester) async {
      await _tests.check_product_details_image_backbutton_overview(
        tester,
        productButtonKey: "$OVERVIEW_GRID_ITEM_DETAILS_KEY\0",
        detailedProduct: _products.elementAt(0),
      );
    });
  }
}
