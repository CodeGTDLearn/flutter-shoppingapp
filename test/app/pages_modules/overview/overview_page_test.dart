import 'dart:io';

import 'package:fake_async/fake_async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/theme/dark_theme_controller.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/overview.dart';
import 'package:shopingapp/app/pages_modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/pages_modules/cart/core/cart_bindings.dart';
import 'package:shopingapp/app/pages_modules/cart/service/i_cart_service.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/core/messages_snackbars_provided.dart';
import 'package:shopingapp/app/pages_modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/pages_modules/overview/service/overview_service.dart';
import 'package:shopingapp/app_driver.dart';

import 'repo/overview_repo_mocks.dart';

// void main() {
class OverviewPageTest {
  static void WidgetIntegrationTests() {
    final binding = BindingsBuilder(() {
      Get.lazyPut<DarkThemeController>(() => DarkThemeController());
      Get.lazyPut<IOverviewRepo>(() => MockRepo());
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

    Finder _findKey(String key) {
      return find.byKey(ValueKey(key));
    }

    Duration _delay(int seconds) {
      return Duration(seconds: seconds);
    }

    List<Product> _products() {
      return Get.find<IOverviewService>().localDataAllProducts;
    }

    testWidgets('1 - Checking Page Elements', (tester) async {
      await tester.pumpWidget(AppDriver());
      _isInstancesRegistred();

      var products = _products();
      await tester.pump();

      expect(find.text(OVERVIEW_TITLE_ALL_APPBAR), findsOneWidget);
      expect(find.text(_products()[0].title.toString()), findsOneWidget);
      expect(find.text(_products()[1].title.toString()), findsOneWidget);
      expect(find.text(_products()[2].title.toString()), findsOneWidget);
      expect(find.text(_products()[3].title.toString()), findsOneWidget);
      expect(find.widgetWithIcon(IconButton, Icons.favorite), findsOneWidget);
      expect(find.widgetWithIcon(IconButton, Icons.favorite_border),
          findsNWidgets(3));
      expect(find.widgetWithIcon(IconButton, Icons.shopping_cart),
          findsNWidgets(5));
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('2 - Toggling favorites status', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      _isInstancesRegistred();

      var key1 = _findKey("$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\0");

      // @formatter:off
      tester
          .tap(key1)
          .then((value) => tester.pumpAndSettle(_delay(1)))
          .then((value) {
              expect(find.widgetWithIcon(IconButton, Icons.favorite),
                  findsNWidgets(2));
              expect(find.widgetWithIcon(IconButton, Icons.favorite_border),
                  findsNWidgets(2));
          });
    });
    // @formatter:on

    testWidgets('3 - Toggling favorites status - Notification',
            (tester) async {
          await tester.pumpWidget(AppDriver());
          await tester.pump();

          _isInstancesRegistred();

          var key1 = _findKey("$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\0");
          expect(find.text(TOGGLE_STATUS_SUCESS), findsNothing);
          await tester.tap(key1);
          expect(find.text(TOGGLE_STATUS_SUCESS), findsNothing);
          await tester.pump();
          expect(find.text(TOGGLE_STATUS_SUCESS), findsOneWidget);
        });

    testWidgets('4 - Add Cart',
            (tester) async {
          await tester.pumpWidget(AppDriver());
          await tester.pump();

          _isInstancesRegistred();

          var key1 = _findKey("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
          expect(find.text("${_products()[0].title}$ITEMCART_ADDED"),
              findsNothing);
          await tester.tap(key1);
          expect(find.text("${_products()[0].title}$ITEMCART_ADDED"),
              findsNothing);
          await tester.pump();
          expect(find.text(OVERVIEW_BADGE_SHOP_CART_APPBAR_KEY).toString(),
            CartController().qtdeCartItems,);
        });

//THE LAST ONE WOULD BE ADD-CART + UNDO, AND CHECK IF THE PRODUCT WAS TAKE
// OUT FROM THE CART

  }
}
