import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/theme/dark_theme_controller.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/managed_products/managed_product_edit.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/managed_products/managed_product_item.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/managed_products/managed_products.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/pages_generic_components/drawwer.dart';
import 'package:shopingapp/app/pages_modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/pages_modules/cart/core/cart_bindings.dart';
import 'package:shopingapp/app/pages_modules/custom_widgets/core/keys/custom_drawer_widgets_keys.dart';
import 'package:shopingapp/app/pages_modules/managed_products/controller/managed_products_controller.dart';
import 'package:shopingapp/app/pages_modules/managed_products/core/managed_products_widget_keys.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/managed_products/repo/i_managed_products_repo.dart';
import 'package:shopingapp/app/pages_modules/managed_products/service/i_managed_products_service.dart';
import 'package:shopingapp/app/pages_modules/managed_products/service/managed_products_service.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/pages_modules/overview/service/overview_service.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../../test_utils/custom_test_methods.dart';
import '../../../../test_utils/test_utils.dart';
import '../../overview/repo/overview_repo_mocks.dart';
import '../repo/managed_products_repo_mocks.dart';

class ManagedProductsPageTest {
  static void functional() {
    TestUtils _seek;
    var scaffoldKey = OVERVIEW_PAGE_MAIN_SCAFFOLD_KEY;
    var titleDrawer = DRAWER_COMPONENT_TITLE_APPBAR;
    var manProdPageTitle = MANAGED_PRODUCTS_PAGE_TITLE;
    var iconAddProduct = MANAGED_PRODUCTS_ICON_ADD_APPBAR;
    var iconEditItem = MANAGED_PRODUCTS_ITEM_TILE_EDIT_ICON;
    var iconDeleteItem = MANAGED_PRODUCTS_ITEM_TILE_DELETE_ICON;
    var drawerMenuOption = DRAWWER_MANAGED_PRODUCTS_MENU_OPTION;

    final binding = BindingsBuilder(() {
      Get.lazyPut<DarkThemeController>(() => DarkThemeController());

      Get.lazyPut<IManagedProductsRepo>(() => ManagedProductsMockRepo());
      Get.lazyPut<IManagedProductsService>(
          () => ManagedProductsService(repo: Get.find<IManagedProductsRepo>()));
      Get.lazyPut<ManagedProductsController>(() => ManagedProductsController(
          service: Get.find<IManagedProductsService>()));

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

      expect(Get.isPrepared<IManagedProductsRepo>(), isFalse);
      expect(Get.isPrepared<IManagedProductsService>(), isFalse);
      expect(Get.isPrepared<ManagedProductsController>(), isFalse);

      binding.builder();

      expect(Get.isPrepared<IOverviewRepo>(), isTrue);
      expect(Get.isPrepared<IOverviewService>(), isTrue);
      expect(Get.isPrepared<OverviewController>(), isTrue);
      expect(Get.isPrepared<CartController>(), isTrue);

      expect(Get.isPrepared<IManagedProductsRepo>(), isTrue);
      expect(Get.isPrepared<IManagedProductsService>(), isTrue);
      expect(Get.isPrepared<ManagedProductsController>(), isTrue);

      HttpOverrides.global = null;
      _seek = TestUtils();
    });

    void _isInstancesRegistred() {
      expect(Get.isRegistered<IOverviewRepo>(), isTrue);
      expect(Get.isRegistered<IOverviewService>(), isTrue);
      expect(Get.isRegistered<OverviewController>(), isTrue);
      expect(Get.isRegistered<CartController>(), isTrue);

      expect(Get.isRegistered<IManagedProductsRepo>(), isTrue);
      expect(Get.isRegistered<IManagedProductsService>(), isTrue);
      expect(Get.isRegistered<ManagedProductsController>(), isTrue);
    }

    List<Product> _prods() {
      return Get.find<IOverviewService>().localDataAllProducts;
    }

    tearDown(() {
      CustomTestMethods.globalTearDown();
      _seek = null;
    });

    Future openDrawer(WidgetTester tester) async {
      scaffoldKey.currentState.openDrawer();
      await tester.pump();
      await tester.pump(_seek.delay(1));
      await tester.tap(_seek.key(drawerMenuOption));
      await tester.pump();
      await tester.pump(_seek.delay(1));
      expect(_seek.text(titleDrawer), findsNothing);
    }

    void checkManagedProductsListedInTheScreen() {
      expect(_seek.text(manProdPageTitle), findsOneWidget);
      expect(_seek.text(_prods()[0].title.toString()), findsOneWidget);
      expect(_seek.text(_prods()[1].title.toString()), findsOneWidget);
      expect(_seek.text(_prods()[2].title.toString()), findsOneWidget);
      expect(_seek.text(_prods()[3].title.toString()), findsOneWidget);
      expect(_seek.icon(iconAddProduct), findsNWidgets(1));
      expect(_seek.icon(iconEditItem), findsNWidgets(4));
      expect(_seek.icon(iconDeleteItem), findsNWidgets(4));
      expect(_seek.type(CircleAvatar), findsNWidgets(4));
    }

    testWidgets('Checking List Managed Products', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      await openDrawer(tester);
      checkManagedProductsListedInTheScreen();
    });

    testWidgets('Deleting a product', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      await openDrawer(tester);
      checkManagedProductsListedInTheScreen();
      var deleteIconProduct1 =
          _seek.key('$MANAGED_PRODUCTS_DELETEITEM_BUTTON_KEY${_prods()[0].id}');
      await tester.tap(deleteIconProduct1);
      await tester.pump();
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.icon(iconEditItem), findsNWidgets(3));
      expect(_seek.icon(iconDeleteItem), findsNWidgets(3));
      expect(_seek.type(CircleAvatar), findsNWidgets(3));
    });

    testWidgets('Updating a product', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      await openDrawer(tester);
      checkManagedProductsListedInTheScreen();

      var newTextToUpdating = "YYYYYY";
      var updateButtonProduct1 =
          _seek.key('$MANAGED_PRODUCTS_UPDATEITEM_BUTTON_KEY${_prods()[0].id}');
      await tester.tap(updateButtonProduct1);
      await tester.pump();
      await tester.pumpAndSettle(_seek.delay(1));

      var manProdAddEditPageTitle = _seek.text(MANAGED_PRODUCTS_ADDEDIT_PAGE_EDIT);
      expect(manProdAddEditPageTitle, findsOneWidget);

      var updatingFieldTitleKey = _seek.key(MANAGED_PRODUCTS_ADDEDIT_FIELD_TITLE_KEY);
      var saveButtonKey =
      _seek.key(MANAGED_PRODUCTS_ADDEDIT_APPBAR_SAVEBUTTON_KEY);

      await tester.enterText(updatingFieldTitleKey, newTextToUpdating);

      await tester.tap(saveButtonKey);//nao esta salvando
      await tester.pump();
      await tester.pump(_seek.delay(3));

      //todo: - Update item test (it is not saving)
      expect(manProdAddEditPageTitle, findsNothing);
      expect(_seek.text(manProdPageTitle), findsOneWidget);

      expect(_seek.text(newTextToUpdating), findsOneWidget);




    });
  }
}
