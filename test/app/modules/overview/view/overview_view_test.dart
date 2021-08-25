import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/snackbarr_keys.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';

import '../../../../config/bindings/overview_test_bindings.dart';
import '../../../../config/tests_config.dart';
import '../../../../config/titles/overview_test_titles.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/finder_utils.dart';
import '../../../../utils/test_global_methods.dart';
import '../../../../utils/test_methods_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'overview_tests.dart';

class OverviewViewTest {
  late bool _isWidgetTest;
  final _finder = Get.put(FinderUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());
  final _bindings = Get.put(OverviewTestBindings());
  final _titles = Get.put(OverviewTestTitles());
  final _testUtils = Get.put(TestMethodsUtils());
  final _globalMethods = Get.put(TestGlobalMethods());
  List<Product> _products = [];

  OverviewViewTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(OverviewTests(
        finder: _finder,
        dbTestUtils: _dbUtils,
        uiTestUtils: _uiUtils,
        isWidgetTest: _isWidgetTest,
        testUtils: _testUtils));

    setUpAll(() async {
      _globalMethods
          .globalSetUpAll('${_tests.runtimeType.toString()} $SHARED_STATE_TITLE');
      _products = await _testUtils.load_ProductList_InDb(
        isWidgetTest: _isWidgetTest,
        totalProducts: 6,
      );
      _bindings.bindingsBuilderMockedRepo(isWidgetTest: _isWidgetTest);
    });

    tearDownAll(() =>
        _globalMethods.globalTearDownAll(_tests.runtimeType.toString(), _isWidgetTest));

    setUp(_globalMethods.globalSetUp);

    tearDown(_globalMethods.globalTearDown);

    testWidgets(_titles.check_overviewGridItems, (tester) async {
      await _tests.check_overviewGridItems(tester, itemsQtde: _products.length);
    });

    testWidgets(_titles.toggle_productFavButton, (tester) async {
      _isWidgetTest
          ? await _tests.toggle_ProductFavoriteButton(
              tester,
              favoritesAfterToggle: 2,
              toggleButtonKey: "$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\0",
            )
          : await _tests.toggle_ProductFavoriteButton(
              tester,
              favoritesAfterToggle: 1,
              toggleButtonKey: "$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\0",
            );
    });

    testWidgets(_titles.add_sameProduct2x_Check_ShopCartIcon, (tester) async {
      await _tests.add_identicalProduct2x_Check_ShopCartIcon(
        tester,
        addProductButtonKey: "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0",
        productTitle: _products[0].title,
        finalTotal: 2,
      );
    });

    testWidgets(_titles.addProduct_click_undoSnackbar_check_shopCartIcon, (tester) async {
      await _tests.addProduct_click_UndoSnackbar_Check_ShopCartIcon(
        tester,
        addProductButtonKey: "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0",
        productTitle: _products[0].title,
        snackbarUndoButtonKey: CUSTOM_SNACKBAR_BUTTON_KEY,
        finalTotal: 2,
      );
    });

    testWidgets(_titles.add_sameProduct3x_check_shopCartIcon, (tester) async {
      await _tests.add_identicalProduct3x_check_shopCartIcon(
        tester,
        productAddButtonKey: "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0",
        finalTotal: 5,
      );
    });

    testWidgets(_titles.add_4differentProducts_check_shopCartIcon, (tester) async {
      await _tests.add_4differentProducts_check_shopCartIcon(
        tester,
        firstProductAddButtonKey: "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0",
        finalTotal: 9,
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
      await _tests.check_product_details(
        tester,
        productButtonKey: "$OVERVIEW_GRID_ITEM_DETAILS_KEY\0",
        detailedProduct: _products[0],
      );
    });

    testWidgets(_titles.tap_product_details_check_image, (tester) async {
      await _tests.check_product_details_image(
        tester,
        productButtonKey: "$OVERVIEW_GRID_ITEM_DETAILS_KEY\0",
        detailedProduct: _products[0],
      );
    });

    testWidgets(_titles.tap_product_details_click_back_button, (tester) async {
      await _tests.tap_viewBackButton(
        tester,
        productButtonKey: "$OVERVIEW_GRID_ITEM_DETAILS_KEY\0",
      );
    });
  }
}
