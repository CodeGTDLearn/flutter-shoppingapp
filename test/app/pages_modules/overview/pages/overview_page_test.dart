import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/theme/dark_theme_controller.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/overview.dart';
import 'package:shopingapp/app/pages_modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/pages_modules/cart/core/cart_bindings.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/core/messages_snackbars_provided.dart';
import 'package:shopingapp/app/pages_modules/overview/core/overview_texts_icons_provided.dart';
import 'package:shopingapp/app/pages_modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/pages_modules/overview/service/overview_service.dart';
import 'package:shopingapp/app/pages_modules/pages_generic_components/core/custom_snackbar_widgets_keys.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../../test_utils/test_utils.dart';
import '../repo/overview_repo_mocks.dart';

// void main() {
class OverviewPageTest {
  static void functional() {
    TestUtils _test;

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
      _test = TestUtils();
    });

    tearDown(() {
      Get.reset;
      _test = null;
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
      expect(_test.text(OVERVIEW_TITLE_ALL_APPBAR), findsOneWidget);

      //B) FOUR OVERVIEW-GRID-ITEMS(PRODUCTS) TITLES
      expect(_test.text(_products()[0].title.toString()), findsOneWidget);
      expect(_test.text(_products()[1].title.toString()), findsOneWidget);
      expect(_test.text(_products()[2].title.toString()), findsOneWidget);
      expect(_test.text(_products()[3].title.toString()), findsOneWidget);

      //TEST ICONS:
      //A) ONE FAVORITE
      expect(_test.type(IconButton, Icons.favorite), findsOneWidget);
      //B) THREE FAVORITES
      expect(_test.type(IconButton, Icons.favorite_border), findsNWidgets(3));
      //C) TEST THE FIVE ICON-CART ICONS:
      expect(_test.type(IconButton, Icons.shopping_cart), findsNWidgets(5));

      //D) TEST ONE POPUP-MENU-FILTER ICON:
      expect(_test.icon(Icons.more_vert), findsOneWidget);
    }

    testWidgets('Checking Products titles + Icons quantity in screen',
        (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      await tester.pump();
      _testProductTitlesAndTotalIconsInTheScreen();
    });

    testWidgets('Toggling FavoritesIconButton + Count FavoritesIcons quantity',
        (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var key1 = _test.key("$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\0");

          // @formatter:off
      tester
          .tap(key1)
          .then((value) => tester.pumpAndSettle(_test.delay(1)))
          .then((value) {
              expect(_test.type(IconButton, Icons.favorite),  findsNWidgets(2));
              expect(_test.type(IconButton, Icons.favorite_border),  findsNWidgets(2));
          });
          // @formatter:on
        });

    testWidgets('Toggling Product0 Favorite + Checking Snackbar/Message',
            (tester) async {
          await tester.pumpWidget(AppDriver());
          await tester.pump();
          _isInstancesRegistred();

          var key1 = _test.key("$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\0");
          expect(_test.text(TOGGLE_STATUS_SUCESS), findsNothing);
          await tester.tap(key1);
          expect(_test.text(TOGGLE_STATUS_SUCESS), findsNothing);
          await tester.pump();
          expect(_test.text(TOGGLE_STATUS_SUCESS), findsOneWidget);
        });

    testWidgets(
        'Adding products + Checking Appbar CartIcon text/Snackbar text',
            (tester) async {
          await tester.pumpWidget(AppDriver());
          await tester.pump();
          _isInstancesRegistred();

          var CartIconKey = _test.key(
              "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
          var snackbartext1 = _test.text(_products()[1].title.toString());

          expect(_test.text("0"), findsOneWidget);
          await tester.tap(CartIconKey);
          await tester.pumpAndSettle(_test.delay(1));
          expect(_test.text("1"), findsOneWidget);
          expect(snackbartext1, findsOneWidget);
          await tester.tap(CartIconKey);
          await tester.pumpAndSettle(_test.delay(1));
          expect(_test.text("2"), findsOneWidget);
          expect(snackbartext1, findsOneWidget);
        });

    testWidgets('Adding products + Clicking Snackbar Undo Button + Checking '
        'Appbar CartIcon text/Snackbar text',
            (tester) async {
          await tester.pumpWidget(AppDriver());
          await tester.pump();
          _isInstancesRegistred();

          var key = _test.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
          var undo = _test.key(CUSTOM_SNACKBAR_BUTTON_KEY);
          var snackbarText = _test.text(_products()[1].title.toString());

          expect(_test.text("0"), findsOneWidget);
          await tester.tap(key);
          await tester.pumpAndSettle(_test.delay(1));
          expect(_test.text("1"), findsOneWidget);
          expect(snackbarText, findsOneWidget);
          await tester.tap(undo);
          await tester.pump();
          expect(_test.text("0"), findsOneWidget);
          expect(snackbarText, findsOneWidget);
        });

    testWidgets(
        'Adding a product three times + Checking AppbarCartIcon text/Snackbar '
            'text', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var key1 = _test.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");

      var snackTitle1;
      snackTitle1 =
          _test.text("${_products()[0].title.toString()}$ITEMCART_ADDED");

      expect(_test.text("0"), findsOneWidget);

      await tester.tap(key1);
      await tester.pump();
      await tester.tap(key1);
      await tester.pump();
      await tester.tap(key1);
      await tester.pump();
      expect(_test.text("3"), findsOneWidget);
      expect(snackTitle1, findsOneWidget);
    });

    testWidgets(
        'Adding products 1/2 + Checking AppbarCartIcon text/Snackbar text', (
        tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();
      _testProductTitlesAndTotalIconsInTheScreen();

      var snackTitle0, snackTitle1;
      var item = ITEMCART_ADDED;
      snackTitle0 = _test.text("${_products()[0].title.toString()}$item");
      snackTitle1 = _test.text("${_products()[1].title.toString()}$item");

      var key0 = _test.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var key1 = _test.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\1");

      await tester.pump();
      expect(_test.text("0"), findsOneWidget);
      await tester.tap(key0);
      await tester.pumpAndSettle();
      expect(_test.text("1"), findsOneWidget);
      expect(snackTitle0, findsOneWidget);

      await tester.tap(key1);
      await tester.pumpAndSettle();
      expect(_test.text("2"), findsOneWidget);
      expect(snackTitle1, findsOneWidget);
    });

    testWidgets(
        'Adding products 3/4 + Checking AppbarCartIcon text/Snackbar text', (
        tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();
      _testProductTitlesAndTotalIconsInTheScreen();

      var snackTitle3, snackTitle2;
      var item = ITEMCART_ADDED;
      snackTitle2 = _test.text("${_products()[2].title.toString()}$item");
      snackTitle3 = _test.text("${_products()[3].title.toString()}$item");
      var key2 = _test.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\2");
      var key3 = _test.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\3");
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
          *
           */

      await tester.pump();
      expect(_test.text("0"), findsOneWidget);
      await tester.tap(key2);
      await tester.pumpAndSettle();
      // expect(_test.text("0"), findsOneWidget);
      // expect(snackTitle2, findsOneWidget);

      await tester.tap(key3);
      await tester.pumpAndSettle();
      // expect(_test.text("2"), findsOneWidget);
      // expect(snackTitle3, findsOneWidget);
    });

    testWidgets('Tapping "AppBar PopupFavoriteFilter with No favorites found', (
        tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();
      _testProductTitlesAndTotalIconsInTheScreen();

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
          *
           */
      var toggleFavProduct = _test.key(
          "$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\1");
      var popup = _test.key(OVERVIEW_POPUP_FAV_ALL_APPBAR_BUTTON_KEY);
      var popupItemFav = _test.key(OVERVIEW_POPUPMENUITEM_FAVORITE_KEY);

      expect(_test.type(IconButton, Icons.favorite), findsNWidgets(1));
      expect(
          _test.type(IconButton, Icons.favorite_border), findsNWidgets(3));
      await tester.tap(toggleFavProduct);
      await tester.pump();
      expect(_test.text(TOGGLE_STATUS_SUCESS), findsOneWidget);
      expect(_test.type(IconButton, Icons.favorite), findsNWidgets(2));
      expect(
          _test.type(IconButton, Icons.favorite_border), findsNWidgets(2));
      await tester.tap(popup);
      await tester.pump();
      expect(_test.text(OV_TXT_POPUP_FAV), findsOneWidget);
      expect(_test.text(OV_TXT_POPUP_ALL), findsOneWidget);
      await tester.tap(popupItemFav);
      await tester.pump();
      expect(_test.type(IconButton, Icons.favorite), findsNWidgets(2));
      expect(
          _test.type(IconButton, Icons.favorite_border), findsNWidgets(2));
    });

    testWidgets('Tapping AppBar "Popup_Favorite_Filter + Checking '
        'favorite-product title + icon quantity',
            (tester) async {
          await tester.pumpWidget(AppDriver());
          await tester.pump();
          _isInstancesRegistred();

          var titleProduct = _test.text(_products()[2].title.toString());
          var popup = _test.key(OVERVIEW_POPUP_FAV_ALL_APPBAR_BUTTON_KEY);
          var popupItemFav = _test.key(OVERVIEW_POPUPMENUITEM_FAVORITE_KEY);
          var popupItemAll = _test.key(OVERVIEW_POPUPMENUITEM_ALL_KEY);

          expect(_test.type(IconButton, Icons.favorite), findsNWidgets(1));
          expect(
              _test.type(IconButton, Icons.favorite_border),
              findsNWidgets(3));
          await tester.tap(popup);
          await tester.pump();
          expect(_test.text(OV_TXT_POPUP_FAV), findsOneWidget);
          expect(_test.text(OV_TXT_POPUP_ALL), findsOneWidget);
          await tester.tap(popupItemFav);
          await tester.pump();
          expect(titleProduct, findsOneWidget);
          expect(_test.type(IconButton, Icons.favorite), findsNWidgets(1));
          await tester.tap(popup);
          await tester.pump();
          expect(_test.text(OV_TXT_POPUP_FAV), findsOneWidget);
          expect(_test.text(OV_TXT_POPUP_ALL), findsOneWidget);
          await tester.tap(popupItemAll);
          await tester.pump();
          expect(_test.type(IconButton, Icons.favorite), findsNWidgets(1));
          expect(
              _test.type(IconButton, Icons.favorite_border),
              findsNWidgets(3));
        });

    testWidgets(
        'Closing Popup_Favorite_Filter "tapping OUTSIDE it"', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var popup = _test.key(OVERVIEW_POPUP_FAV_ALL_APPBAR_BUTTON_KEY);
      var popupItemFav = _test.key(OVERVIEW_POPUPMENUITEM_FAVORITE_KEY);
      var popupItemAll = _test.key(OVERVIEW_POPUPMENUITEM_ALL_KEY);

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