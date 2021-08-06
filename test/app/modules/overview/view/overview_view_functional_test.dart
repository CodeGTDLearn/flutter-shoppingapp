import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/snackbarr_keys.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';

import '../../../../config/app_tests_config.dart';
import '../../../../config/overview_test_config.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'overview_tests.dart';

class OverviewViewTest {
  late bool _isWidgetTest;
  final TestUtils _utils = Get.put(TestUtils());
  final UiTestUtils _uiUtils = Get.put(UiTestUtils());
  final DbTestUtils _dbUtils = Get.put(DbTestUtils());
  final OverviewTestConfig _config = Get.put(OverviewTestConfig());

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

    setUpAll(() async => _utils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _utils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _utils.globalSetUp("Starting...");
      _config.bindingsBuilderMockedRepo(isWidgetTest: _isWidgetTest);
    });

    tearDown(() => _utils.globalTearDown("...Ending"));

    testWidgets(_config.check_OverviewGridItemsInOverviewView, (tester) async {
      await _utils.load_2ProductsInDb_ReturnAProduct(tester, isWidgetTest: _isWidgetTest);
      _isWidgetTest
          ? await _tests.check_OverviewGridItemsInOverviewView(tester, itemsQtde: 4)
          : await _tests.check_OverviewGridItemsInOverviewView(tester, itemsQtde: 2);
    });
    // }, skip: false);

    testWidgets(_config.toggle_ProductFavoriteButton, (tester) async {
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
    // }, skip: false);

    testWidgets(_config.addProduct_CheckShopCartIconAndSnackbar, (tester) async {
      var product = await _utils.load_2ProductsInDb_ReturnAProduct(
        tester,
        isWidgetTest: _isWidgetTest,
      );
      await _tests.addProduct_CheckShopCartIconAndSnackbar(
        tester,
        addProductButtonKey: "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0",
        productTitle: product.title,
      );
    });
    // }, skip: false);

    testWidgets(_config.addProduct_ClickUndoInSnackbar, (tester) async {
      var product = await _utils.load_2ProductsInDb_ReturnAProduct(
        tester,
        isWidgetTest: _isWidgetTest,
      );
      await _tests.addProduct_ClickUndoInSnackbar(
        tester,
        addProductButtonKey: "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0",
        productTitle: product.title,
        snackbarUndoButtonKey: CUSTOM_SNACKBAR_BUTTON_KEY,
      );
    });
    // }, skip: false);

    testWidgets(_config.add_SameProduct_3x_CheckingShopCartIcon, (tester) async {
      var prods = await _utils.load_4ProductsInDb_ReturnAProductList(
        tester,
        isWidgetTest: _isWidgetTest,
      );

      await _tests.add_SameProduct_3x_CheckingShopCartIcon(
        tester,
        listProducts: prods,
        addProductButtonKey: "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0",
      );
    });

    testWidgets(_config.add_4DifferentProducts_CheckingShopCartIcon, (tester) async {
      // await _utils.load_4ProductsInDb_ReturnAProductList(
      //   tester,
      //   isWidgetTest: _isWidgetTest,
      // );

      await _tests.add_4DifferentProducts_CheckingShopCartIcon(
        tester,
        addOnlyTheFirstProductButtonKey: "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0",
      );
    });

    testWidgets(_config.tap_FavoritesFilter_NoFavoritesFound, (tester) async {
      await _utils.load_4ProductsInDb_ReturnAProductList(
        tester,
        isWidgetTest: _isWidgetTest,
      );
      await _tests.tap_FavoritesFilter_NoFavoritesFound(tester);
    });

    testWidgets(_config.tap_FavoriteFilterPopup, (tester) async {
      await _tests.tap_FavoriteFilterPopup(tester);
    });

    testWidgets(_config.close_FavoriteFilterPopup, (tester) async {
      await _tests.close_FavoriteFilterPopup(tester);
    });
  }
}
