import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/theme/dark_theme_controller.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/managed_products/managed_products.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/overview.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/pages_generic_components/drawwer.dart';
import 'package:shopingapp/app/pages_modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/pages_modules/cart/core/cart_bindings.dart';
import 'package:shopingapp/app/pages_modules/custom_widgets/core/keys/custom_drawer_widgets_keys.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/pages_modules/overview/service/overview_service.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../test_utils/custom_test_methods.dart';
import '../../../test_utils/test_utils.dart';
import '../overview/repo/overview_repo_mocks.dart';

class CustomDrawerTest {
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

      CustomTestMethods.globalTearDown();
    });

    void _isInstancesRegistred() {
      expect(Get.isRegistered<IOverviewRepo>(), isTrue);
      expect(Get.isRegistered<IOverviewService>(), isTrue);
      expect(Get.isRegistered<OverviewController>(), isTrue);
      expect(Get.isRegistered<CartController>(), isTrue);
    }

    List<Product> _products() {
      return Get.find<IOverviewService>().getLocalDataAllProducts;
    }

    testWidgets('Checking OverviewPage BEFORE open "Custom Drawer"',
        (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      await tester.pump();

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

    testWidgets('Testing "Custom Drawer" control, in Appbar', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var scaffoldKey = OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY;
      var titleDrawer = DRAWER_COMPONENT_TITLE_APPBAR;

      await tester.pump(); // no effect
      expect(seek.text(titleDrawer), findsNothing);
      scaffoldKey.currentState.openDrawer();
      await tester.pump(); // drawer should be starting to animate in
      expect(seek.text(titleDrawer), findsOneWidget);
      await tester.pump(seek.delay(1)); // animation done
      expect(seek.text(titleDrawer), findsOneWidget);
      await tester.tap(seek.text(titleDrawer));
      await tester.pump(); // nothing should have happened
      expect(seek.text(titleDrawer), findsOneWidget);
      await tester.pump(seek.delay(1)); // ditto
      expect(seek.text(titleDrawer), findsOneWidget);
      await tester.tapAt(const Offset(750.0, 100.0)); // on the mask
      await tester.pump();
      expect(seek.text(titleDrawer), findsOneWidget);
      await tester.pump(seek.delay(1)); // animation done
      expect(seek.text(titleDrawer), findsNothing);
    });

    testWidgets('Tapping "Custom Drawer", in Appbar', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var scaffoldKey = OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY;
      var titleDrawer = DRAWER_COMPONENT_TITLE_APPBAR;

      expect(seek.text(titleDrawer), findsNothing);
      scaffoldKey.currentState.openDrawer();
      await tester.pump();
      await tester.pump(seek.delay(1));
      expect(seek.text(titleDrawer), findsOneWidget);
      await tester.tapAt(const Offset(750.0, 100.0)); // on the mask
      await tester.pump();
      await tester.pump(seek.delay(1)); // animation done
      expect(seek.text(titleDrawer), findsNothing);
    });

    testWidgets('Tapping a menu "option" in Custom Drawer', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var scaffoldKey = OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY;
      var menuOptionKey = seek.key(DRAWWER_MANAGED_PRODUCTS_MENU_OPTION);
      var titleDrawer = DRAWER_COMPONENT_TITLE_APPBAR;
      var manProdPageTitle = MANAGED_PRODUCTS_PAGE_TITLE;

      expect(seek.text(titleDrawer), findsNothing);
      scaffoldKey.currentState.openDrawer();
      await tester.pump();
      await tester.pump(seek.delay(1));
      expect(seek.text(titleDrawer), findsOneWidget);
      await tester.tap(menuOptionKey);
      await tester.pump();
      await tester.pump(seek.delay(1));
      expect(seek.text(manProdPageTitle), findsOneWidget);
    });
  }
}
