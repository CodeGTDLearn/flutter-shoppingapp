import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/snackbarr_keys.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';

import '../../../../config/tests_config.dart';
import '../../../../config/bindings/overview_test_bindings.dart';
import '../../../../config/titles/overview_test_titles.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'overview_tests.dart';

class OverviewViewTest {
  late bool _isWidgetTest;
  final _utils = Get.put(TestUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());
  final _bindings = Get.put(OverviewTestBindings());
  final _titles = Get.put(OverviewTestTitles());
  var _products;

  OverviewViewTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(OverviewTests(
      testUtils: _utils,
      dbTestUtils: _dbUtils,
      uiTestUtils: _uiUtils,
      isWidgetTest: _isWidgetTest,
    ));

    setUpAll(() async {
      _utils.globalSetUpAll(_tests.runtimeType.toString());
      _products = await _utils.load_4ProductsInDb(isWidgetTest: _isWidgetTest);
      _bindings.bindingsBuilderMockedRepo(isWidgetTest: _isWidgetTest);
    });

    tearDownAll(() => _utils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() => _utils.globalSetUp("Starting..."));

    tearDown(() => _utils.globalTearDown("...Ending Test"));

    testWidgets(_titles.check_overviewGridItems_in_overviewview, (tester) async {
      _isWidgetTest
          ? await _tests.check_OverviewGridItems_In_OverviewView(tester, itemsQtde: 4)
          : await _tests.check_OverviewGridItems_In_OverviewView(tester, itemsQtde: 4);
    });

    testWidgets(_titles.toggle_productFavoriteButton, (tester) async {
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

    testWidgets(_titles.add_identicalProduct2x_Check_ShopCartIcon, (tester) async {
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

    testWidgets(_titles.add_identicalProduct3x_check_shopCartIcon, (tester) async {
      await _tests.add_identicalProduct3x_Check_ShopCartIcon(
        tester,
        productAddButtonKey: "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0",
        finalTotal: 5,
      );
    });

    testWidgets(_titles.add_4differentProducts_check_shopCartIcon, (tester) async {
      await _tests.add_4differentProducts_Check_ShopCartIcon(
        tester,
        firstProductAddButtonKey: "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0",
        finalTotal: 9,
      );
    });

    testWidgets(_titles.tap_favoritesFilter_noFavoritesFound, (tester) async {
      await _tests.tap_FavoritesFilter_NoFavoritesFound(tester);
    });

    testWidgets(_titles.tap_favoriteFilterPopup, (tester) async {
      await _tests.tap_FavoriteFilterPopup(tester);
    });

    testWidgets(_titles.close_favoriteFilterPopup, (tester) async {
      await _tests.close_FavoriteFilterPopup(tester);
    });
  }
}
