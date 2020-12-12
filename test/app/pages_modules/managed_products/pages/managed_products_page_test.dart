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
import 'package:shopingapp/app/pages_modules/pages_generic_components/core/custom_drawer_widgets_keys.dart';
import 'package:shopingapp/app/pages_modules/pages_generic_components/core/texts_icons/drawwer_texts_icons_provided.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../../test_utils/test_utils.dart';
import '../../overview/repo/overview_repo_mocks.dart';

class ManagedProductsPageTest {
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

    testWidgets('Checking OverviewPage Elements before tap Drawer',
        (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      await tester.pump();

      expect(_test.text(OVERVIEW_TITLE_ALL_APPBAR), findsOneWidget);
      expect(_test.text(_products()[0].title.toString()), findsOneWidget);
      expect(_test.text(_products()[1].title.toString()), findsOneWidget);
      expect(_test.text(_products()[2].title.toString()), findsOneWidget);
      expect(_test.text(_products()[3].title.toString()), findsOneWidget);
      expect(_test.type(IconButton, Icons.favorite), findsOneWidget);
      expect(
          _test.type(IconButton, Icons.favorite_border), findsNWidgets(3));
      expect(_test.type(IconButton, Icons.shopping_cart), findsNWidgets(5));
      expect(_test.icon(Icons.more_vert), findsOneWidget);
      expect(_test.key(K_DRW), findsOneWidget);
    });

    testWidgets('Tapping AppBar Drawer + Managed Products menu option',
        (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var scaffoldKey = OVERVIEW_PAGE_MAIN_SCAFFOLD_KEY;
      var key = _test.key(DRAWWER_MANAGED_PRODUCTS_MENU_OPTION);

      //-------------------------

      await tester.tap(find.byType(Drawer).first);
      await tester.pump(); // drawer should appear

      expect(find.text(DRW_TIT_APPBAR), findsOneWidget);
      // expect(find.byIcon(Icons.add), findsOneWidget);
      // await tester.tap(find.byIcon(Icons.add));
      // print('end of test');

      //----------------------

    });

    testWidgets('Closing Popup_Favorite_Filter (tapping OUTSIDE it)',
        (tester) async {
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
