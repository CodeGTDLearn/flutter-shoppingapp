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
import 'package:shopingapp/app/pages_modules/managed_products/core/messages/field_form_validation_provided.dart';
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
    var scaffoldKey = OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY;
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
        () => ManagedProductsService(
            repo: Get.find<IManagedProductsRepo>(),
            overviewService: Get.find<IOverviewService>()),
      );
      Get.lazyPut<ManagedProductsController>(
        () => ManagedProductsController(
            service: Get.find<IManagedProductsService>()),
      );

      Get.lazyPut<IOverviewRepo>(() => OverviewMockRepo());
      Get.lazyPut<IOverviewService>(
        () => OverviewService(repo: Get.find<IOverviewRepo>()),
      );
      Get.lazyPut<OverviewController>(
        () => OverviewController(service: Get.find<IOverviewService>()),
      );

      CartBindings().dependencies();
    });

    setUp(() {
      expect(Get.isPrepared<DarkThemeController>(), isFalse);
      expect(Get.isPrepared<IOverviewRepo>(), isFalse);
      expect(Get.isPrepared<IOverviewService>(), isFalse);
      expect(Get.isPrepared<OverviewController>(), isFalse);
      expect(Get.isPrepared<CartController>(), isFalse);

      expect(Get.isPrepared<IManagedProductsRepo>(), isFalse);
      expect(Get.isPrepared<IManagedProductsService>(), isFalse);
      expect(Get.isPrepared<ManagedProductsController>(), isFalse);

      binding.builder();

      expect(Get.isPrepared<DarkThemeController>(), isTrue);
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

    void _checkRegistredInstances() {
      expect(Get.isRegistered<IOverviewRepo>(), isTrue);
      expect(Get.isRegistered<IOverviewService>(), isTrue);
      expect(Get.isRegistered<OverviewController>(), isTrue);
      expect(Get.isRegistered<CartController>(), isTrue);

      expect(Get.isRegistered<IManagedProductsRepo>(), isTrue);
      expect(Get.isRegistered<IManagedProductsService>(), isTrue);
      expect(Get.isRegistered<ManagedProductsController>(), isTrue);
    }

    List<Product> _prods() {
      return Get.find<IOverviewService>().getLocalDataAllProducts;
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

    void checkManagedProductsPageAndItsListedProducts() {
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

    testWidgets('Checking Listed Products in the page', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _checkRegistredInstances();

      await openDrawer(tester);
      checkManagedProductsPageAndItsListedProducts();
    });

    testWidgets('Deleting a product', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _checkRegistredInstances();

      await openDrawer(tester);
      checkManagedProductsPageAndItsListedProducts();

      var deleteIconProduct1 =
          _seek.key('$MANAGED_PRODUCTS_DELETEITEM_BUTTON_KEY${_prods()[0].id}');
      await tester.tap(deleteIconProduct1);
      await tester.pump();
      await tester.pumpAndSettle(_seek.delay(3));
      expect(_seek.icon(iconEditItem), findsNWidgets(3));
      expect(_seek.icon(iconDeleteItem), findsNWidgets(3));
      expect(_seek.type(CircleAvatar), findsNWidgets(3));
    });

    testWidgets('Updating a product', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _checkRegistredInstances();

      var productTitle = _prods()[0].title;
      var productPrice = _prods()[0].price;
      var productDesc = _prods()[0].description;
      var productUrl = _prods()[0].imageUrl;

      var newTitle = 'xxxxxx';
      var newDesc = 'xxxxxxxxxxxx';
      var updateButtonProduct1 =
          _seek.key('$MANAGED_PRODUCTS_UPDATEITEM_BUTTON_KEY${_prods()[0].id}');
      var titleFieldKey = _seek.key(MANAGED_PRODUCTS_ADDEDIT_FIELD_TITLE_KEY);
      var descFieldKey = _seek.key(MANAGED_PRODUCTS_ADDEDIT_FIELD_DESCRIPT_KEY);
      var saveButtonKey = _seek.key(MANAGED_PRODUCTS_ADDEDIT_SAVEBUTTON_KEY);
      var manProdAddEditPageTitle =
          _seek.text(MANAGED_PRODUCTS_ADDEDIT_TITLEPAGE_EDIT);

      await openDrawer(tester);
      checkManagedProductsPageAndItsListedProducts();

      // 1) Click in 'First Product UpdateIcon' +  Open ManProductsAddEditPage
      await tester.tap(updateButtonProduct1);
      await tester.pump();
      await tester.pumpAndSettle(_seek.delay(1));

      // 2) Checking the titlePage + All Fields
      expect(manProdAddEditPageTitle, findsOneWidget);
      expect(_seek.text(productTitle), findsOneWidget);
      expect(_seek.text(productPrice.toString()), findsOneWidget);
      expect(_seek.text(productDesc), findsOneWidget);
      expect(_seek.text(productUrl), findsOneWidget);

      // 3) Change the productTitle - productDesc
      await tester.tap(titleFieldKey);
      await tester.enterText(titleFieldKey, newTitle);
      await tester.tap(descFieldKey);
      await tester.enterText(descFieldKey, newDesc);
      await tester.pump();
      await tester.pump(_seek.delay(2));

      // 4) Checking the 'New title' + 'New Desc' + Other Fields
      expect(_seek.text(newTitle), findsOneWidget);
      expect(_seek.text(productPrice.toString()), findsOneWidget);
      expect(_seek.text(newDesc), findsOneWidget);
      expect(_seek.text(productUrl), findsOneWidget);

      // 5) Save form + Back to ManProductsPage + Test INValidation messages
      await tester.tap(saveButtonKey);
      await tester.pump();
      await tester.pump(_seek.delay(4));
      expect(_seek.text(INVALID_TITLE_MSG), findsNothing);
      expect(_seek.text(INVALID_PRICE_MSG), findsNothing);
      expect(_seek.text(INVALID_DESCR_MSG), findsNothing);
      expect(_seek.text(INVALID_URL_MSG), findsNothing);

      // 6) Checking the Updating in the previous page
      expect(manProdAddEditPageTitle, findsNothing);
      expect(_seek.text(manProdPageTitle), findsOneWidget);
      expect(_seek.text(newTitle), findsOneWidget);
    });

    testWidgets('Refreshing page - Refresh-Indicator', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _checkRegistredInstances();

      await openDrawer(tester);
      checkManagedProductsPageAndItsListedProducts();

      var dragInitialPointElement =
          _seek.key('$MANAGED_PRODUCT_ITEM_KEY${_prods()[0].id}');
      await tester.drag(dragInitialPointElement, Offset(0.0, -50.0));
      await tester.pump();
      await tester.pumpAndSettle(_seek.delay(1));

      expect(_seek.type(RefreshIndicator), findsNWidgets(1));
    });
  }
}
