import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/keys/overview_keys.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';
import 'package:shopingapp/app/modules/overview/components/custom_grid_item/animated_grid_item.dart';
import 'package:shopingapp/app/modules/overview/view/overview_item_details_view.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../config/app_tests_properties.dart';
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
      widgetType: AnimatedGridItem,
      widgetQtde: qtde,
    );
  }

  Future<void> add_sameProduct2x_check_shopCartIcon(
    WidgetTester tester, {
    required String productTitle,
    required int qtdeToAdded,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );
    final _controller = Get.find<CartController>();

    for (var i = 0; i < qtdeToAdded; i++) {
      var addProductButtonKey = '$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY$i';
      await tester.tap(finder.key(addProductButtonKey));
      await tester.pumpAndSettle(testUtils.delay(DELAY));
      expect(
        finder.text(_controller.qtdeCartItemsObs.value.toString()),
        findsOneWidget,
      );
    }
  }

  Future<void> add_product_click_undoSnackbar_check_shopCartIcon(
    WidgetTester tester, {
    required String addProductButtonKey,
    required String productTitle,
    required String snackbarUndoButtonKey,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    final _controller = Get.find<CartController>();

    await tester.tap(finder.key(addProductButtonKey));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text(productTitle), findsWidgets);
    expect(finder.text(_controller.qtdeCartItemsObs.value.toString()), findsOneWidget);

    await tester.tap(finder.key(snackbarUndoButtonKey));
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text(_controller.qtdeCartItemsObs.value.toString()), findsOneWidget);
  }

  Future<void> add_sameProduct3x_check_shopCartIcon(
    WidgetTester tester, {
    required String productAddButtonKey,
    required int qtdeToAdded,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    final _controller = Get.find<CartController>();

    for (var i = 0; i < qtdeToAdded; i++) {
      await tester.tap(finder.key(productAddButtonKey));
      await tester.pump();
      await tester.pumpAndSettle(testUtils.delay(DELAY));
      expect(
        finder.text(_controller.qtdeCartItemsObs.value.toString()),
        findsOneWidget,
      );
    }

    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(finder.text(qtdeToAdded.toString()), findsOneWidget);
  }

  Future<void> add_allProducts_check_shopCartIcon(
    WidgetTester tester, {
    required int qtdeToAdded,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    final _controller = Get.find<CartController>();

    for (var i = 0; i < qtdeToAdded; i++) {
      var addProductButtonKey = '$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY$i';
      await tester.tap(finder.key(addProductButtonKey));
      await tester.pump();
      await tester.pumpAndSettle(testUtils.delay(DELAY));
      expect(
        finder.text(_controller.qtdeCartItemsObs.value.toString()),
        findsOneWidget,
      );
    }

    await tester.pumpAndSettle(testUtils.delay(DELAY));
  }

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
      widgetType: AnimatedGridItem,
      widgetQtde: itemsQtde,
    );
  }

  Future<void> toggle_favoriteButton_in_overviewGridItem(
    WidgetTester tester, {
    required String toggleButtonKey,
    required totalProducts,
  }) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    var favoritesIcons = finder.countItemsFromFinder(
      finder.iconType(IconButton, Icons.favorite),
    );

    var unfavoritesIcons = finder.countItemsFromFinder(
      finder.iconType(IconButton, Icons.favorite_border),
    );

    expect(totalProducts, favoritesIcons + unfavoritesIcons);

    await tester.tap(finder.key(toggleButtonKey));
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    favoritesIcons = finder.countItemsFromFinder(
      finder.iconType(IconButton, Icons.favorite),
    );

    unfavoritesIcons = finder.countItemsFromFinder(
      finder.iconType(IconButton, Icons.favorite_border),
    );

    expect(totalProducts, favoritesIcons + unfavoritesIcons);
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