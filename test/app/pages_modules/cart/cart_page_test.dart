import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/theme/dark_theme_controller.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/cart.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/overview.dart';
import 'package:shopingapp/app/pages_modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/pages_modules/cart/core/cart_bindings.dart';
import 'package:shopingapp/app/pages_modules/cart/core/cart_widget_keys.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/pages_modules/overview/service/overview_service.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../test_utils/global_test_methods.dart';
import '../../../test_utils/utils.dart';
import '../overview/repo/overview_repo_mocks.dart';

class CartPageTest {
  static void functional() {
    Utils _seek;

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
      _seek = Utils();
    });

    tearDown(() {
      GlobalTestMethods.tearDown();
      _seek = null;
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

    testWidgets('Adding products + Checking Appbar CartIcon text/Snackbar text',
        (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var CartIconKey = _seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var snackbartext1 = _seek.text(_products()[1].title.toString());

      expect(_seek.text("0"), findsOneWidget);
      await tester.tap(CartIconKey);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text("1"), findsOneWidget);
      expect(snackbartext1, findsOneWidget);
      await tester.tap(CartIconKey);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text("2"), findsOneWidget);
      expect(snackbartext1, findsOneWidget);
    });

    testWidgets('Acessing Cart Page',
        (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var CartIconKey = _seek.key("$OVERVIEW_GRID_ITEM_CART_BUTTON_KEY\0");
      var snackbartext1 = _seek.text(_products()[1].title.toString());
      var cartButton = _seek.key(SHOP_CART_APPBAR_BUTTON_KEY);

      expect(_seek.text("0"), findsOneWidget);
      await tester.tap(CartIconKey);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text("1"), findsOneWidget);
      expect(snackbartext1, findsOneWidget);
      await tester.tap(cartButton);
      await tester.tap(CartIconKey);
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text(CART_TITLE_PAGE), findsOneWidget);
      expect(_seek.text(_products()[0].title), findsOneWidget);
      expect(_seek.text(_products()[0].description), findsOneWidget);
      expect(_seek.text(_products()[0].price.toString()), findsOneWidget);
      // expect(_seek.text('x${_cartItem.qtde}'), findsOneWidget);



    });
  }
}
