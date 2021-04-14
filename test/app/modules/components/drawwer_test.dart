import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/theme/dark_theme_controller.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/components/drawwer.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/inventory/inventory.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/overview.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/modules/cart/core/cart_bindings.dart';
import 'package:shopingapp/app/modules/components/core/keys/progres_indicator_keys.dart';
import 'package:shopingapp/app/modules/components/core/keys/drawwer_keys.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/service/overview_service.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../test_utils/test_utils.dart';
import '../overview/repo/overview_repo_mocks.dart';

class DrawwerTest {
  static void functional() {
    TestUtils seek;

    final binding = BindingsBuilder(() {
      Get.lazyPut<DarkThemeController>(() => DarkThemeController());

      Get.lazyPut<IOverviewRepo>(() => OverviewMockRepo());

      Get.lazyPut<IOverviewService>(
          () => OverviewService(repo: Get.find<IOverviewRepo>()));

      Get.lazyPut<OverviewController>(
          () => OverviewController(service: Get.find<IOverviewService>()));

      // Get.lazyPut<ManagedProductsController>(() => ManagedProductsController());

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
      seek = null;

      TestMethods.globalTearDown();
    });

    void _isInstancesRegistred() {
      expect(Get.isRegistered<IOverviewRepo>(), isTrue);
      expect(Get.isRegistered<IOverviewService>(), isTrue);
      expect(Get.isRegistered<OverviewController>(), isTrue);
      expect(Get.isRegistered<CartController>(), isTrue);
    }

    List<Product> _products() {
      return Get.find<IOverviewService>().getLocalDataAllProducts();
    }

    testWidgets('Checking Overview BEFORE open Drawer', (tester) async {
      await tester.pumpWidget(AppDriver());
      _isInstancesRegistred();

      expect(seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);
      expect(seek.text(NO_PRODUCTS_FOUND_IN_YET), findsNothing);

      await tester.pump();
      await tester.pump(seek.delay(3));
      expect(seek.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
      expect(seek.text(_products()[0].title.toString()), findsOneWidget);
      expect(seek.text(_products()[1].title.toString()), findsOneWidget);
      expect(seek.text(_products()[2].title.toString()), findsOneWidget);
      expect(seek.text(_products()[3].title.toString()), findsOneWidget);
      expect(seek.iconType(IconButton, Icons.favorite), findsOneWidget);
      expect(
          seek.iconType(IconButton, Icons.favorite_border), findsNWidgets(3));
      expect(seek.iconType(IconButton, Icons.shopping_cart), findsNWidgets(5));
      expect(seek.iconData(Icons.more_vert), findsOneWidget);
      expect(seek.key(K_DRW_APPBAR_BTN), findsOneWidget);
    });

    testWidgets('Tapping Drawer', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var scaffoldKey = OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY;
      var titleDrawer = DRAWER_COMPONENT_TITLE_APPBAR;

      // Tapping three times
      for (var counter = 0; counter <= 2; counter++) {
        expect(seek.text(titleDrawer), findsNothing);
        expect(scaffoldKey.currentState.isDrawerOpen, isFalse);
        scaffoldKey.currentState.openDrawer();
        await tester.pump();
        await tester.pump(seek.delay(1));
        expect(scaffoldKey.currentState.isDrawerOpen, isTrue);
        expect(seek.text(titleDrawer), findsOneWidget);
        await tester.tapAt(const Offset(750.0, 100.0)); // on the mask
        await tester.pump();
        await tester.pump(seek.delay(1)); // animation done
        expect(seek.text(titleDrawer), findsNothing);
        expect(scaffoldKey.currentState.isDrawerOpen, isFalse);
      }
    });

    testWidgets('Tapping Drawer, closing tapping outside', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var scaffoldKey = OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY;
      var titleDrawer = DRAWER_COMPONENT_TITLE_APPBAR;

      expect(seek.text(titleDrawer), findsNothing);
      expect(scaffoldKey.currentState.isDrawerOpen, isFalse);
      scaffoldKey.currentState.openDrawer();
      await tester.pump();
      await tester.pump(seek.delay(3));
      expect(scaffoldKey.currentState.isDrawerOpen, isTrue);
      expect(seek.text(titleDrawer), findsOneWidget);
      await tester.tapAt(const Offset(750.0, 100.0)); // on the mask
      await tester.pump();
      await tester.pump(seek.delay(3)); // animation done
      expect(seek.text(titleDrawer), findsNothing);
    });

    testWidgets('Tapping Two Drawer Options', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var scaffoldKey = OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY;
      var titleDrawer = DRAWER_COMPONENT_TITLE_APPBAR;
      var ovViewPageTitle = OVERVIEW_TITLE_PAGE_ALL;
      var manProdPageTitle = INVENTORY_PAGE_TITLE;
      var manProdDrawerOption = seek.key(DRAWWER_MANAGED_PRODUCTS_OPTION);
      var ovViewDrawerOption = seek.key(DRAWWER_OVERVIEW_OPTION);

      for (var counter = 1; counter <= 2; counter++) {
        expect(seek.text(titleDrawer), findsNothing);
        scaffoldKey.currentState.openDrawer();
        await tester.pump();
        await tester.pump(seek.delay(3));
        expect(seek.text(titleDrawer), findsOneWidget);
        counter == 1
            ? await tester.tap(ovViewDrawerOption)
            : await tester.tap(manProdDrawerOption);
        await tester.pump();
        await tester.pump(seek.delay(3));
        counter == 1
            ? expect(seek.text(ovViewPageTitle), findsOneWidget)
            : expect(seek.text(manProdPageTitle), findsOneWidget);

      }
    });
  }
}
