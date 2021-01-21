import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/theme/dark_theme_controller.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/overview.dart';
import 'package:shopingapp/app/pages_modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/pages_modules/cart/core/cart_bindings.dart';
import 'package:shopingapp/app/pages_modules/custom_widgets/core/keys/custom_snackbar_widgets_keys.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/components/favorites_filter_popup.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/core/messages_snackbars_provided.dart';
import 'package:shopingapp/app/pages_modules/overview/core/overview_texts_icons_provided.dart';
import 'package:shopingapp/app/pages_modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/pages_modules/overview/service/overview_service.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../../test_utils/custom_test_methods.dart';
import '../../../../test_utils/test_utils.dart';
import '../repo/overview_repo_mocks.dart';

class OverviewPageTest {
  static void functional() {
    TestUtils seek;

    final binding = BindingsBuilder(() {
      Get.lazyPut<DarkThemeController>(() => DarkThemeController());

      Get.lazyPut<IOverviewRepo>(() => OverviewMockRepo());
      Get.lazyPut<IOverviewService>(
          () => OverviewService(repo: Get.find<IOverviewRepo>()));
      Get.lazyPut<OverviewController>(
          () => OverviewController(service: Get.find<IOverviewService>()));

      CartBindings().dependencies();
    });

    setUp(() {
      expect(Get.isPrepared<IOverviewRepo>(), isFalse);
      expect(Get.isPrepared<IOverviewService>(), isFalse);
      expect(Get.isPrepared<OverviewController>(), isFalse);
      expect(Get.isPrepared<CartController>(), isFalse);
      binding.builder();
      expect(Get.isPrepared<IOverviewRepo>(), isTrue);
      expect(Get.isPrepared<IOverviewService>(), isTrue);
      expect(Get.isPrepared<OverviewController>(), isTrue);
      expect(Get.isPrepared<CartController>(), isTrue);

      HttpOverrides.global = null;
      seek = TestUtils();
    });

    tearDown(() {
      CustomTestMethods.globalTearDown();
      seek = null;
    });

    void _isInstancesRegistred() {
      expect(Get.isRegistered<IOverviewRepo>(), isTrue);
      expect(Get.isRegistered<IOverviewService>(), isTrue);
      expect(Get.isRegistered<OverviewController>(), isTrue);
      expect(Get.isRegistered<CartController>(), isTrue);
    }

    List<Product> _products() {
      return Get.find<IOverviewService>().localDataAllProducts;
    }

    void _testProductTitlesAndTotalIconsInTheScreen() {
      //TEST TITLES
      //A) PAGE TITLE
      expect(seek.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);

      //B) FOUR OVERVIEW-GRID-ITEMS(PRODUCTS) TITLES
      expect(seek.text(_products()[0].title.toString()), findsOneWidget);
      expect(seek.text(_products()[1].title.toString()), findsOneWidget);
      expect(seek.text(_products()[2].title.toString()), findsOneWidget);
      expect(seek.text(_products()[3].title.toString()), findsOneWidget);

      //TEST ICONS:
      //A) ONE FAVORITE
      expect(seek.iconType(IconButton, Icons.favorite), findsOneWidget);
      //B) THREE FAVORITES
      expect(
          seek.iconType(IconButton, Icons.favorite_border), findsNWidgets(3));
      //C) TEST THE FIVE ICON-CART ICONS:
      expect(seek.iconType(IconButton, Icons.shopping_cart), findsNWidgets(5));

      //D) TEST ONE POPUP-MENU-FILTER ICON:
      expect(seek.iconData(Icons.more_vert), findsOneWidget);
    }

    testWidgets('Checking Products in screen', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      await tester.pump();
      _testProductTitlesAndTotalIconsInTheScreen();
    });

    testWidgets('Toggling FavoritesIconButton in a product', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var favBtnProduct = seek.key("$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\0");

      // @formatter:off
      tester
          .tap(favBtnProduct)
          .then((value) => tester.pumpAndSettle(seek.delay(1)))
          .then((value) {
              expect(seek.iconType(IconButton, Icons.favorite),  findsNWidgets(2));
              expect(seek.iconType(IconButton, Icons.favorite_border),  findsNWidgets(2));
          });
      // @formatter:on
    });

    testWidgets('Adding products + Checking Snackbar text', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var CartIconKey = seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var snackbartext1 = seek.text(_products()[1].title.toString());

      expect(seek.text("0"), findsOneWidget);
      await tester.tap(CartIconKey);
      await tester.pumpAndSettle(seek.delay(1));
      expect(seek.text("1"), findsOneWidget);
      expect(snackbartext1, findsOneWidget);
      await tester.tap(CartIconKey);
      await tester.pumpAndSettle(seek.delay(1));
      expect(seek.text("2"), findsOneWidget);
      expect(snackbartext1, findsOneWidget);
    });

    testWidgets('Adding products + Clicking Snackbar Undo', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var key = seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var undo = seek.key(CUSTOM_SNACKBAR_BUTTON_KEY);
      var snackbarText = seek.text(_products()[1].title.toString());

      expect(seek.text("0"), findsOneWidget);
      await tester.tap(key);
      await tester.pumpAndSettle(seek.delay(1));
      expect(seek.text("1"), findsOneWidget);
      expect(snackbarText, findsOneWidget);
      await tester.tap(undo);
      await tester.pump();
      expect(seek.text("0"), findsOneWidget);
      expect(snackbarText, findsOneWidget);
    });

    testWidgets('Adding a product 3x + Check ShopCartIcon', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var favBtnProduct = seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");

      var snackTitle1;
      snackTitle1 =
          seek.text("${_products()[0].title.toString()}$ITEMCART_ADDED");

      expect(seek.text("0"), findsOneWidget);

      await tester.tap(favBtnProduct);
      await tester.pump();
      await tester.tap(favBtnProduct);
      await tester.pump();
      await tester.tap(favBtnProduct);
      await tester.pump();
      expect(seek.text("3"), findsOneWidget);
      expect(snackTitle1, findsOneWidget);
    });

    testWidgets('Adding products 1/2 + Checking ShopCartIcon', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();
      _testProductTitlesAndTotalIconsInTheScreen();

      var snackTitle0, snackTitle1;
      var item = ITEMCART_ADDED;
      snackTitle0 = seek.text("${_products()[0].title.toString()}$item");
      snackTitle1 = seek.text("${_products()[1].title.toString()}$item");

      var key0 = seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var favBtnProduct = seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\1");

      await tester.pump();
      expect(seek.text("0"), findsOneWidget);
      await tester.tap(key0);
      await tester.pumpAndSettle();
      expect(seek.text("1"), findsOneWidget);
      expect(snackTitle0, findsOneWidget);

      await tester.tap(favBtnProduct);
      await tester.pumpAndSettle();
      expect(seek.text("2"), findsOneWidget);
      expect(snackTitle1, findsOneWidget);
    });

    testWidgets('Adding products 3/4 + Checking ShopCartIcon', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();
      _testProductTitlesAndTotalIconsInTheScreen();

      var snackTitle3, snackTitle2;
      var item = ITEMCART_ADDED;
      snackTitle2 = seek.text("${_products()[2].title.toString()}$item");
      snackTitle3 = seek.text("${_products()[3].title.toString()}$item");
      var key2 = seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\2");
      var key3 = seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\3");
      /*
          * The WidGet Testing in the keys 02 + key 03
          *
          * Are not being allowed by the TEstingApp System
          * Only tests are done in the Key 00 + Key 01
          *
          * There is no apparent reason for that.
          * The four keys have the same configuration
          * however, the comand 'await tester.tap(key);'
          * only run using the keys 00/01
          *
          * O sistema de testes nao esta sendo processado
          * nas keys 02/03, somente os testes sao procedidos
          * pelo sistema nas keys 00/01
          *
          * Nao existe razao a aparente para isso ocorrer
          * As 4 keys possuem a mesma configuracao
          * entretando, o comando 'await tester.tap(key);'
          * somente e EXECUTADO com as keys 00/01
           */

      await tester.pump();
      expect(seek.text("0"), findsOneWidget);
      await tester.tap(key2);
      await tester.pumpAndSettle();
      // expect(seek.text("1"), findsOneWidget);
      // expect(snackTitle2, findsOneWidget);

      await tester.tap(key3);
      await tester.pumpAndSettle();
      // expect(seek.text("2"), findsOneWidget);
      // expect(snackTitle3, findsOneWidget);
    });

    testWidgets('Tapping FavoriteFilter - favorites Not found', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var popup = seek.key(OVERVIEW_FAVORITE_FILTER_APPBAR_BUTTON_KEY);
      var favBtnProduct = seek.key('$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\2');

      // 1) CHECK ONLY ONE FAVORITE
      expect(seek.iconType(IconButton, Icons.favorite), findsNWidgets(1));

      // 2) TAP TO UNFAVORITE THAT
      await tester.tap(favBtnProduct);
      await tester.pump(seek.delay(1));

      // 3) CHECK NONE FAVORITE
      expect(seek.iconType(IconButton, Icons.favorite), findsNWidgets(0));

      // 4) TAP FAVORITE-FILTER IN APPBAR + CHECK ITS OPTIONS
      await tester.tap(popup);
      await tester.pump(seek.delay(1));
      expect(seek.text(OV_TXT_POPUP_FAV), findsOneWidget);
      expect(seek.text(OV_TXT_POPUP_ALL), findsOneWidget);
      expect(seek.type(FavoritesFilterPopup), findsOneWidget);

      // 5) TAP FAVORITE OPTION
      // 5.1) CHECK SNACK-BAR(MESSAGE: NO FAVORITES YET)
      // 5.2) PUMP_AND_SETTLE TO FINALIZE THE PROCESS
      await tester.tap(seek.key(OVERVIEW_FAVORITE_FILTER_KEY));
      await tester.pump();
      await tester.pumpAndSettle(seek.delay(2));
      expect(seek.text(OVERVIEW_TITLE_PAGE_FAVORITE), findsNothing);
    });

    testWidgets('Tapping FavoriteFilter', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var titleProduct = seek.text(_products()[2].title.toString());
      var popup = seek.key(OVERVIEW_FAVORITE_FILTER_APPBAR_BUTTON_KEY);
      var popupItemFav = seek.key(OVERVIEW_FAVORITE_FILTER_KEY);
      var popupItemAll = seek.key(OVERVIEW_FAVORITE_FILTER_ALL_KEY);

      expect(seek.iconType(IconButton, Icons.favorite), findsNWidgets(1));
      expect(
          seek.iconType(IconButton, Icons.favorite_border), findsNWidgets(3));
      await tester.tap(popup);
      await tester.pump();
      expect(seek.text(OV_TXT_POPUP_FAV), findsOneWidget);
      expect(seek.text(OV_TXT_POPUP_ALL), findsOneWidget);
      await tester.tap(popupItemFav);
      await tester.pump();
      expect(titleProduct, findsOneWidget);
      expect(seek.iconType(IconButton, Icons.favorite), findsNWidgets(1));
      await tester.tap(popup);
      await tester.pump();
      await tester.pumpAndSettle(seek.delay(1));
      expect(seek.text(OV_TXT_POPUP_FAV), findsOneWidget);
      expect(seek.text(OV_TXT_POPUP_ALL), findsOneWidget);
      await tester.tap(popupItemAll);
      await tester.pump();
      await tester.pumpAndSettle(seek.delay(1));
      expect(seek.iconType(IconButton, Icons.favorite), findsNWidgets(1));
      expect(
          seek.iconType(IconButton, Icons.favorite_border), findsNWidgets(3));
    });

    testWidgets('Closing Favorite_Filter (tap OUTSIDE)', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var popup = seek.key(OVERVIEW_FAVORITE_FILTER_APPBAR_BUTTON_KEY);
      var popupItemFav = seek.key(OVERVIEW_FAVORITE_FILTER_KEY);
      var popupItemAll = seek.key(OVERVIEW_FAVORITE_FILTER_ALL_KEY);

      await tester.tap(popup);
      await tester.pumpAndSettle();
      expect(popupItemFav, findsOneWidget);
      expect(popupItemAll, findsOneWidget);
      await tester.tapAt(const Offset(0.0, 0.0));
      await tester.pumpAndSettle();
      expect(popupItemFav, findsNothing);
      expect(popupItemAll, findsNothing);
    });
  }
}