import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';
import 'package:shopingapp/app/modules/overview/components/overview_grid_item.dart';
import 'package:shopingapp/app/modules/overview/view/overview_item_details_view.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../config/tests_properties.dart';
import '../../../../utils/finder_utils.dart';
import '../../../../utils/testdb_utils.dart';
import '../../../../utils/tests_utils.dart';
import '../../../../utils/ui_test_utils.dart';

class OverviewTests {
  final bool isWidgetTest;
  final FinderUtils finder;
  final UiTestUtils uiTestUtils;
  final TestDbUtils dbTestUtils;
  final TestsUtils testUtils;

  OverviewTests({
    required this.finder,
    required this.uiTestUtils,
    required this.isWidgetTest,
    required this.dbTestUtils,
    required this.testUtils,
  });

  Future<void> check_overviewGridItems_qtde(
    WidgetTester tester, {
    required int qtde,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    uiTestUtils.check_widgetQuantityInAView(
      widgetView: OverviewView,
      widgetType: OverviewGridItem,
      widgetQtde: qtde,
    );
  }

  Future<void> add_sameProduct2x_Check_ShopCartIcon(
    WidgetTester tester, {
    required String addProductButtonKey,
    required String productTitle,
    required int initialQtde,
    required int qtdeToAdded,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    for (var i = 0; i < (qtdeToAdded - initialQtde); i++) {
      await tester.tap(finder.key(addProductButtonKey));
      await tester.pumpAndSettle(testUtils.delay(DELAY));
    }

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text(qtdeToAdded.toString()), findsOneWidget);
    expect(finder.text(productTitle), findsWidgets);
  }

  Future<void> addProduct_click_undoSnackbar_check_shopCartIcon(
    WidgetTester tester, {
    required String addProductButtonKey,
    required String productTitle,
    required String snackbarUndoButtonKey,
    required int total,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    await tester.tap(finder.key(addProductButtonKey));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text(productTitle), findsWidgets);
    await tester.tap(finder.key(snackbarUndoButtonKey));
    await tester.pump();
    expect(finder.text(total.toString()), findsOneWidget);
    await tester.pumpAndSettle(testUtils.delay(DELAY));
  }

  Future<void> add_sameProduct3x_check_shopCartIcon(
    WidgetTester tester, {
    required String productAddButtonKey,
    required int initialQtde,
    required int qtdeToAdded,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY + 5));
    for (var i = 0; i < (qtdeToAdded - initialQtde); i++) {
      await tester.tap(finder.key(productAddButtonKey));
    }

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text(qtdeToAdded.toString()), findsOneWidget);
  }

  Future<void> add_AllProducts_check_shopCartIcon(
    WidgetTester tester, {
    required String firstProduct_addButtonKey,
    required int initialQtde,
    required int qtdeToAdded,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    //POSSIBLE TAP-ERROR:
    // "To silence this warning, pass "warnIfMissed: false" to "tap()".
    // To make this warning fatal, set WidgetController.hitTestWarningShouldBeFatal to
    // true.
    // Warning: A call to tap() with finder "exactly one widget with key"
    //SOLUTION:
    // - CHANGE
    //   - 'await tester.pumpAndSettle(testUtils.delay(DELAY));' TO
    //   - 'await tester.pump();'

    // await tester.pumpAndSettle(testUtils.delay(DELAY));
    for (var i = 0; i < (qtdeToAdded - initialQtde); i++) {
      await tester
          .tap(finder.key(firstProduct_addButtonKey.replaceFirst('0', i.toString())));
      await tester.pump();
    }

    expect(finder.text(qtdeToAdded.toString()), findsOneWidget);
  }

  // Future<void> tap_FavoritesFilter_NoFavoritesFound(tester) async {
  //   await uiTestUtils.testInitialization(
  //     tester,
  //     isWidgetTest: isWidgetTest,
  //     appDriver: app.AppDriver(),
  //     applyDelay: true,
  //   );
  //
  //   var fav_item_button_key = OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY;
  //
  //   await tester.pump();
  //   await tester.pumpAndSettle(testUtils.delay(DELAY));
  //   if (isWidgetTest) await tester.tap(finder.key('$fav_item_button_key\2'));
  //   if (!isWidgetTest) await tester.tap(finder.key('$fav_item_button_key\0'));
  //
  //   await tester.pumpAndSettle(testUtils.delay(DELAY));
  //   expect(finder.iconType(Icons, Icons.favorite), findsNothing);
  //
  //   await tester.tap(finder.key(OVERVIEW_POPUP_FILTER_APPBAR_BUTTON_KEY));
  //   await tester.pumpAndSettle(testUtils.delay(DELAY));
  //
  //   var favPopupOption = finder.key(OVERVIEW_POPUP_FILTER_FAVORITE_OPTION_KEY);
  //   await tester.ensureVisible(favPopupOption);
  //   await tester.tap(favPopupOption);
  //   await tester.pump();
  //   // await tester.pumpAndSettle(testUtils.delay(DELAY));
  //
  //   expect(finder.text(OVERVIEW_TITLE_PAGE_FAVORITE), findsNothing);
  //   expect(finder.text(FAVORITES_NOT_FOUND_YET), findsOneWidget);
  //   await tester.pumpAndSettle(testUtils.delay(DELAY));
  // }
  //
  // Future<void> tap_FavoriteFilterPopup(tester) async {
  //   await uiTestUtils.testInitialization(
  //     tester,
  //     isWidgetTest: isWidgetTest,
  //     appDriver: app.AppDriver(),
  //     applyDelay: true,
  //   );
  //
  //   var popup = OVERVIEW_POPUP_FILTER_APPBAR_BUTTON_KEY;
  //
  //   await tester.pumpAndSettle(testUtils.delay(DELAY));
  //   await tester.tap(finder.key('$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\0'));
  //
  //   await tester.pumpAndSettle(testUtils.delay(DELAY));
  //   await tester.tap(finder.key(popup));
  //
  //   await tester.pumpAndSettle(testUtils.delay(DELAY));
  //   await tester.tap(finder.key(OVERVIEW_POPUP_FILTER_FAVORITE_OPTION_KEY));
  //
  //   await tester.pumpAndSettle(testUtils.delay(DELAY));
  //   expect(finder.text(OVERVIEW_TITLE_PAGE_FAVORITE), findsOneWidget);
  //   expect(finder.type(OverviewGridItem), findsWidgets);
  //
  //   await tester.tap(finder.key(popup));
  //   await tester.pumpAndSettle(testUtils.delay(DELAY));
  //
  //   await tester.tap(finder.key(OVERVIEW_POPUP_FILTER_ALL_OPTION_KEY));
  //   await tester.pumpAndSettle(testUtils.delay(DELAY));
  //
  //   expect(finder.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
  // }

  Future<void> check_favorites_overview(
    tester,
    int itemsQtde,
  ) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    uiTestUtils.check_widgetQuantityInAView(
      widgetView: OverviewView,
      widgetType: OverviewGridItem,
      widgetQtde: itemsQtde,
    );
  }

  Future<void> toggle_FavoriteButton_in_product(
    WidgetTester tester, {
    required String toggleButtonKey,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    var qtdeTypes = finder.countItemsFromFinder(
      finder.iconType(IconButton, Icons.favorite),
    );

    if (qtdeTypes == 0) {
      await tester.tap(finder.key(toggleButtonKey));
      await tester.pumpAndSettle(testUtils.delay(DELAY));
      qtdeTypes = 1;
    }

    expect(
      finder.iconType(IconButton, Icons.favorite),
      findsNWidgets(qtdeTypes),
    );
  }

  Future<void> check_product_details_image_backbutton_overview(
    WidgetTester tester, {
    required String productButtonKey,
    required Product detailedProduct,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    // await tester.pump();
    // await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(finder.key(productButtonKey));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    testUtils.checkImageTotalInAView(1);

    await uiTestUtils.navigateBetweenViews(
      tester,
      from: OverviewItemDetailsView,
      to: OverviewView,
      trigger: BackButton,
      interval: DELAY,
    );
    await tester.pumpAndSettle(testUtils.delay(DELAY));
  }

  Future<void> check_product_details_backbutton_overview(
    WidgetTester tester, {
    required String productButtonKey,
    required Product detailedProduct,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    // await tester.pump();
    // await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(finder.key(productButtonKey));
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text(detailedProduct.title), findsWidgets);
    expect(finder.text('\$${detailedProduct.price}'), findsOneWidget);
    expect(finder.text(detailedProduct.description), findsOneWidget);

    await uiTestUtils.navigateBetweenViews(
      tester,
      from: OverviewItemDetailsView,
      to: OverviewView,
      trigger: BackButton,
      interval: DELAY,
    );
    await tester.pumpAndSettle(testUtils.delay(DELAY));
  }

  Future<void> tap_viewBackButton(
    WidgetTester tester, {
    required String productButtonKey,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    // await tester.pump();
    // await tester.pumpAndSettle(testUtils.delay(DELAY));
    await tester.tap(finder.key(productButtonKey));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    await uiTestUtils.navigateBetweenViews(
      tester,
      from: OverviewItemDetailsView,
      to: OverviewView,
      trigger: BackButton,
      interval: DELAY,
    );
    await tester.pumpAndSettle(testUtils.delay(DELAY));
  }
}