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
import 'package:shopingapp/app/pages_modules/pages_generic_components/pages_generics_components_widgets_keys.dart';
import 'package:shopingapp/app_driver.dart';

import 'repo/overview_repo_mocks.dart';

// void main() {
class OverviewPageTest {
  static void widgetTests() {
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
      expect(Get.isPrepared<IOverviewRepo>(), false);
      expect(Get.isPrepared<IOverviewService>(), false);
      expect(Get.isPrepared<OverviewController>(), false);
      expect(Get.isPrepared<CartController>(), false);
      binding.builder();
      expect(Get.isPrepared<IOverviewRepo>(), true);
      expect(Get.isPrepared<IOverviewService>(), true);
      expect(Get.isPrepared<OverviewController>(), true);
      expect(Get.isPrepared<CartController>(), true);

      HttpOverrides.global = null;
    });

    tearDown(() {
      Get.reset;
    });

    void _isInstancesRegistred() {
      expect(Get.isRegistered<IOverviewRepo>(), true);
      expect(Get.isRegistered<IOverviewService>(), true);
      expect(Get.isRegistered<OverviewController>(), true);
      expect(Get.isRegistered<CartController>(), true);
    }

    Finder _key(String key) {
      return find.byKey(ValueKey(key));
    }

    Finder _text(String text) {
      return find.text(text);
    }

    Finder _type(Type button, IconData icon) {
      return find.widgetWithIcon(button, icon);
    }

    Finder _icon(IconData icon) {
      return find.byIcon(icon);
    }

    Duration _delay(int seconds) {
      return Duration(seconds: seconds);
    }

    List<Product> _products() {
      return Get.find<IOverviewService>().localDataAllProducts;
    }

    testWidgets('Checking Page Elements', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var products = _products();
      await tester.pump();

      expect(_text(OVERVIEW_TITLE_ALL_APPBAR), findsOneWidget);
      expect(_text(_products()[0].title.toString()), findsOneWidget);
      expect(_text(_products()[1].title.toString()), findsOneWidget);
      expect(_text(_products()[2].title.toString()), findsOneWidget);
      expect(_text(_products()[3].title.toString()), findsOneWidget);

      expect(_type(IconButton, Icons.favorite), findsOneWidget);
      expect(_type(IconButton, Icons.favorite_border), findsNWidgets(3));
      expect(_type(IconButton, Icons.shopping_cart), findsNWidgets(5));

      expect(_icon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('Toggling favorites status', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var key1 = _key("$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\0");

      // @formatter:off
      tester
          .tap(key1)
          .then((value) => tester.pumpAndSettle(_delay(1)))
          .then((value) {
              expect(_type(IconButton, Icons.favorite),  findsNWidgets(2));
              expect(_type(IconButton, Icons.favorite_border),  findsNWidgets(2));
          });
      // @formatter:on
    });

    testWidgets('Toggling favorites - Notification', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var key1 = _key("$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\0");
      expect(_text(TOGGLE_STATUS_SUCESS), findsNothing);
      await tester.tap(key1);
      expect(_text(TOGGLE_STATUS_SUCESS), findsNothing);
      await tester.pump();
      expect(_text(TOGGLE_STATUS_SUCESS), findsOneWidget);
    });

    testWidgets('Adding product in the Cart', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var key = _key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var snackbartext1 = _text(_products()[1].title.toString());

      expect(_text("0"), findsOneWidget);
      await tester.tap(key);
      await tester.pumpAndSettle(_delay(1));
      expect(_text("1"), findsOneWidget);
      expect(snackbartext1, findsOneWidget);
      await tester.tap(key);
      await tester.pumpAndSettle(_delay(1));
      expect(_text("2"), findsOneWidget);
      expect(snackbartext1, findsOneWidget);
    });

    testWidgets('Adding+Remove(Undo) product in the Cart', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var key = _key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var undo = _key(CUSTOM_SNACKBAR_BUTTON_KEY);
      var snackbartext1 = _text(_products()[1].title.toString());

      expect(_text("0"), findsOneWidget);
      await tester.tap(key);
      await tester.pumpAndSettle(_delay(1));
      expect(_text("1"), findsOneWidget);
      expect(snackbartext1, findsOneWidget);
      await tester.tap(undo);
      await tester.pump();
      expect(_text("0"), findsOneWidget);
      expect(snackbartext1, findsOneWidget);
    });


    testWidgets('Adding ALL product in the Cart', (tester) async {
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

    testWidgets('Tapping AppBar Popup_Favorite_Filter (No favorites)', (
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

    testWidgets('Tapping AppBar Popup_Favorite_Filter', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var titleProduct = _text(_products()[2].title.toString());
      var popup = _key(OVERVIEW_POPUP_FAV_ALL_APPBAR_BUTTON_KEY);
      var popupItemFav = _key(OVERVIEW_POPUPMENUITEM_FAVORITE_KEY);
      var popupItemAll = _key(OVERVIEW_POPUPMENUITEM_ALL_KEY);

      expect(_type(IconButton, Icons.favorite), findsNWidgets(1));
      expect(_type(IconButton, Icons.favorite_border), findsNWidgets(3));
      await tester.tap(popup);
      await tester.pump();
      expect(_text(OV_TXT_POPUP_FAV), findsOneWidget);
      expect(_text(OV_TXT_POPUP_ALL), findsOneWidget);
      await tester.tap(popupItemFav);
      await tester.pump();
      expect(titleProduct, findsOneWidget);
      expect(_type(IconButton, Icons.favorite), findsNWidgets(1));
      await tester.tap(popup);
      await tester.pump();
      expect(_text(OV_TXT_POPUP_FAV), findsOneWidget);
      expect(_text(OV_TXT_POPUP_ALL), findsOneWidget);
      await tester.tap(popupItemAll);
      await tester.pump();
      expect(_type(IconButton, Icons.favorite), findsNWidgets(1));
      expect(_type(IconButton, Icons.favorite_border), findsNWidgets(3));
    });

    testWidgets(
        'Closing Popup_Favorite_Filter (tapping OUTSIDE that)', (
        tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var popup = _key(OVERVIEW_POPUP_FAV_ALL_APPBAR_BUTTON_KEY);
      var popupItemFav = _key(OVERVIEW_POPUPMENUITEM_FAVORITE_KEY);
      var popupItemAll = _key(OVERVIEW_POPUPMENUITEM_ALL_KEY);

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

