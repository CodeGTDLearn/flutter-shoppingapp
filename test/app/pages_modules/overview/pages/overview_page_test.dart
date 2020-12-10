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
import 'package:shopingapp/app/pages_modules/pages_generic_components/core/pages_generics_comp_widgets_keys.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../../test_utils/test_utils.dart';
import '../repo/overview_repo_mocks.dart';

// void main() {
class OverviewPageTest {
  static void functional() {
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
    });

    tearDown(() {
      Get.reset;
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

    testWidgets('Checking Products titles + Icons quantity in screen',
        (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      await tester.pump();

      expect(TestUtils.text(OVERVIEW_TITLE_ALL_APPBAR), findsOneWidget);
      expect(TestUtils.text(_products()[0].title.toString()), findsOneWidget);
      expect(TestUtils.text(_products()[1].title.toString()), findsOneWidget);
      expect(TestUtils.text(_products()[2].title.toString()), findsOneWidget);
      expect(TestUtils.text(_products()[3].title.toString()), findsOneWidget);

      expect(TestUtils.type(IconButton, Icons.favorite), findsOneWidget);
      expect(
          TestUtils.type(IconButton, Icons.favorite_border), findsNWidgets(3));
      expect(TestUtils.type(IconButton, Icons.shopping_cart), findsNWidgets(5));

      expect(TestUtils.icon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('Toggling FavoritesIconButton + Count FavoritesIcons quantity',
        (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var key1 = TestUtils.key("$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\0");

          // @formatter:off
      tester
          .tap(key1)
          .then((value) => tester.pumpAndSettle(TestUtils.delay(1)))
          .then((value) {
              expect(TestUtils.type(IconButton, Icons.favorite),  findsNWidgets(2));
              expect(TestUtils.type(IconButton, Icons.favorite_border),  findsNWidgets(2));
          });
      // @formatter:on
        });

    testWidgets('Toggling Product0 Favorite + Checking Snackbar/Message',
            (tester) async {
          await tester.pumpWidget(AppDriver());
          await tester.pump();
          _isInstancesRegistred();

          var key1 = TestUtils.key("$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\0");
          expect(TestUtils.text(TOGGLE_STATUS_SUCESS), findsNothing);
          await tester.tap(key1);
          expect(TestUtils.text(TOGGLE_STATUS_SUCESS), findsNothing);
          await tester.pump();
          expect(TestUtils.text(TOGGLE_STATUS_SUCESS), findsOneWidget);
        });

    testWidgets(
        'Adding products + Checking Appbar CartIcon text/Snackbar text',
            (tester) async {
          await tester.pumpWidget(AppDriver());
          await tester.pump();
          _isInstancesRegistred();

          var CartIconKey = TestUtils.key(
              "$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
          var snackbartext1 = TestUtils.text(_products()[1].title.toString());

          expect(TestUtils.text("0"), findsOneWidget);
          await tester.tap(CartIconKey);
          await tester.pumpAndSettle(TestUtils.delay(1));
          expect(TestUtils.text("1"), findsOneWidget);
          expect(snackbartext1, findsOneWidget);
          await tester.tap(CartIconKey);
          await tester.pumpAndSettle(TestUtils.delay(1));
          expect(TestUtils.text("2"), findsOneWidget);
          expect(snackbartext1, findsOneWidget);
        });

    testWidgets('Adding products + Clicking Snackbar Undo Button + Checking '
        'Appbar CartIcon text/Snackbar text',
            (tester) async {
          await tester.pumpWidget(AppDriver());
          await tester.pump();
          _isInstancesRegistred();

          var key = TestUtils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
          var undo = TestUtils.key(CUSTOM_SNACKBAR_BUTTON_KEY);
          var snackbarText = TestUtils.text(_products()[1].title.toString());

          expect(TestUtils.text("0"), findsOneWidget);
          await tester.tap(key);
          await tester.pumpAndSettle(TestUtils.delay(1));
          expect(TestUtils.text("1"), findsOneWidget);
          expect(snackbarText, findsOneWidget);
          await tester.tap(undo);
          await tester.pump();
          expect(TestUtils.text("0"), findsOneWidget);
          expect(snackbarText, findsOneWidget);
        });


    testWidgets(
        'Adding all products + Checking AppbarCartIcon text/Snackbar text', (
        tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var key1 = TestUtils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var key2 = TestUtils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\1");
      // var key3 = Utils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\2");
      var key3 = TestUtils.key("$OV02\2");

      var key4 = TestUtils.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\3");

      var snackTitle1, snackTitle4, snackTitle2, snackTitle3;
      var item = ITEMCART_ADDED;
      snackTitle1 = TestUtils.text("${_products()[0].title.toString()}$item");
      snackTitle2 = TestUtils.text("${_products()[1].title.toString()}$item");
      snackTitle3 = TestUtils.text("${_products()[2].title.toString()}$item");
      snackTitle4 = TestUtils.text("${_products()[3].title.toString()}$item");

      expect(TestUtils.text("0"), findsOneWidget);

      await tester.tap(key1);
      await tester.pump();
      expect(TestUtils.text("1"), findsOneWidget);
      expect(snackTitle1, findsOneWidget);

      await tester.tap(key2);
      await tester.pump();
      expect(TestUtils.text("2"), findsOneWidget);
      expect(snackTitle1, findsOneWidget);

      await tester.tap(key3);
      await tester.pump();
      expect(TestUtils.text("3"), findsOneWidget);
      expect(snackTitle2, findsOneWidget);

      // await tester.tap(key4);
      // await tester.pumpAndSettle(TestUtils.delay(15));
      // expect(Utils.text("4"), findsOneWidget);
      // expect(snackbarTitle3, findsOneWidget);
    });

    testWidgets('>>>>>>>>>>>Adding All displayed products in the Cart',
            (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var key0 = _key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var key1 = _key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\1");
      var key2 = _key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\2");
      var key3 = _key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\3");

      var snackbar_title1 = _text(_products()[0].title.toString());
      var snackbar_title2 = _text(_products()[1].title.toString());
      var snackbar_title3 = _text(_products()[2].title.toString());
      var snackbar_title4 = _text(_products()[3].title.toString());

      expect(_text("0"), findsOneWidget);
      await tester.tap(key0);
      await tester.pump();
      expect(_text("1"), findsOneWidget);
      expect(snackbar_title1, findsOneWidget);
      await tester.tap(key1);
      await tester.pump();
      expect(_text("2"), findsOneWidget);
      expect(snackbar_title2, findsOneWidget);
      await tester.tap(key2);
      await tester.pump();
      expect(_text("3"), findsOneWidget);
      expect(snackbar_title3, findsOneWidget);
      await tester.tap(key3);
      await tester.pump();
      expect(_text("4"), findsOneWidget);
      expect(snackbar_title4, findsOneWidget);
    });

    testWidgets('Tapping "AppBar PopupFavoriteFilter with No favorites found', (
        tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var toggleFavProduct = TestUtils.key(
          "$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\2");
      var popup = TestUtils.key(OVERVIEW_POPUP_FAV_ALL_APPBAR_BUTTON_KEY);
      var popupItemFav = TestUtils.key(OVERVIEW_POPUPMENUITEM_FAVORITE_KEY);

      expect(TestUtils.type(IconButton, Icons.favorite), findsNWidgets(1));
      expect(
          TestUtils.type(IconButton, Icons.favorite_border), findsNWidgets(3));
      await tester.tap(toggleFavProduct);
      await tester.pump();
      expect(TestUtils.text(TOGGLE_STATUS_SUCESS), findsOneWidget);
      expect(TestUtils.type(IconButton, Icons.favorite), findsNWidgets(0));
      expect(
          TestUtils.type(IconButton, Icons.favorite_border), findsNWidgets(4));
      await tester.tap(popup);
      await tester.pump();
      expect(TestUtils.text(OV_TXT_POPUP_FAV), findsOneWidget);
      expect(TestUtils.text(OV_TXT_POPUP_ALL), findsOneWidget);
      await tester.tap(popupItemFav);
      await tester.pump();
      expect(TestUtils.type(IconButton, Icons.favorite), findsNWidgets(0));
      expect(
          TestUtils.type(IconButton, Icons.favorite_border), findsNWidgets(4));
    });

    testWidgets('>>>>>>>>>>Tapping AppBar Popup_Favorite_Filter (No favorites '
        'found)', (
        tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var toggleFavProduct = _key("$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\2");
      var popup = _key(OVERVIEW_POPUP_FAV_ALL_APPBAR_BUTTON_KEY);
      var popupItemFav = _key(OVERVIEW_POPUPMENUITEM_FAVORITE_KEY);

      expect(_type(IconButton, Icons.favorite), findsNWidgets(1));
      expect(_type(IconButton, Icons.favorite_border), findsNWidgets(3));
      await tester.tap(toggleFavProduct);
      await tester.pump();
      expect(_text(TOGGLE_STATUS_SUCESS), findsOneWidget);
      expect(_type(IconButton, Icons.favorite), findsNWidgets(0));
      expect(_type(IconButton, Icons.favorite_border), findsNWidgets(4));
      await tester.tap(popup);
      await tester.pump();
      expect(_text(OV_TXT_POPUP_FAV), findsOneWidget);
      expect(_text(OV_TXT_POPUP_ALL), findsOneWidget);
      await tester.tap(popupItemFav);
      await tester.pump();
      expect(_type(IconButton, Icons.favorite), findsNWidgets(0));
      expect(_type(IconButton, Icons.favorite_border), findsNWidgets(4));
    });

    testWidgets('Tapping AppBar "Popup_Favorite_Filter + Checking '
        'favorite-product title + icon quantity',
            (tester) async {
          await tester.pumpWidget(AppDriver());
          await tester.pump();
          _isInstancesRegistred();

          var titleProduct = TestUtils.text(_products()[2].title.toString());
          var popup = TestUtils.key(OVERVIEW_POPUP_FAV_ALL_APPBAR_BUTTON_KEY);
          var popupItemFav = TestUtils.key(OVERVIEW_POPUPMENUITEM_FAVORITE_KEY);
          var popupItemAll = TestUtils.key(OVERVIEW_POPUPMENUITEM_ALL_KEY);

          expect(TestUtils.type(IconButton, Icons.favorite), findsNWidgets(1));
          expect(
              TestUtils.type(IconButton, Icons.favorite_border),
              findsNWidgets(3));
          await tester.tap(popup);
          await tester.pump();
          expect(TestUtils.text(OV_TXT_POPUP_FAV), findsOneWidget);
          expect(TestUtils.text(OV_TXT_POPUP_ALL), findsOneWidget);
          await tester.tap(popupItemFav);
          await tester.pump();
          expect(titleProduct, findsOneWidget);
          expect(TestUtils.type(IconButton, Icons.favorite), findsNWidgets(1));
          await tester.tap(popup);
          await tester.pump();
          expect(TestUtils.text(OV_TXT_POPUP_FAV), findsOneWidget);
          expect(TestUtils.text(OV_TXT_POPUP_ALL), findsOneWidget);
          await tester.tap(popupItemAll);
          await tester.pump();
          expect(TestUtils.type(IconButton, Icons.favorite), findsNWidgets(1));
          expect(
              TestUtils.type(IconButton, Icons.favorite_border),
              findsNWidgets(3));
        });

    testWidgets(
        'Closing Popup_Favorite_Filter "tapping OUTSIDE it"', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var popup = TestUtils.key(OVERVIEW_POPUP_FAV_ALL_APPBAR_BUTTON_KEY);
      var popupItemFav = TestUtils.key(OVERVIEW_POPUPMENUITEM_FAVORITE_KEY);
      var popupItemAll = TestUtils.key(OVERVIEW_POPUPMENUITEM_ALL_KEY);

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