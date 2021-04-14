import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/theme/dark_theme_controller.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/inventory/inventory.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/inventory/inventory_add_edit.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/overview.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/modules/cart/core/cart_bindings.dart';
import 'package:shopingapp/app/modules/components/core/keys/drawwer_keys.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/controller/inventory_controller.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/inventory/core/messages/field_form_validation_provided.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/inventory/repo/i_inventory_repo.dart';
import 'package:shopingapp/app/modules/inventory/service/i_inventory_service.dart';
import 'package:shopingapp/app/modules/inventory/service/inventory_service.dart';
import 'package:shopingapp/app/modules/overview/components/overview_grid_item.dart';
import 'package:shopingapp/app/modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/service/overview_service.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../../test_utils/test_utils.dart';
import '../../overview/repo/overview_repo_mocks.dart';
import '../repo/managed_products_repo_mocks.dart';

class ManagedProductsPageTest {
  static void functional() {
    TestUtils _seek;
    var ovViewScaffGlobalKey = OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY;
    var manProdPageTitle = INVENTORY_PAGE_TITLE;
    var iconAddProduct = INVENTORY_ICON_ADD_APPBAR;
    var managedProductsDrawerOption = DRAWWER_MANAGED_PRODUCTS_OPTION;

    final binding = BindingsBuilder(() {
      Get.lazyPut<DarkThemeController>(() => DarkThemeController());

      Get.lazyPut<IInventoryRepo>(() => ManagedProductsMockRepo());

      Get.lazyPut<IInventoryService>(
        () => InventoryService(
            repo: Get.find(), overviewService: Get.find()),
      );

      Get.lazyPut<InventoryController>(
        () => InventoryController(service: Get.find()),
      );

      Get.lazyPut<IOverviewRepo>(() => OverviewMockRepo());

      Get.lazyPut<IOverviewService>(
        () => OverviewService(repo: Get.find()),
      );

      Get.lazyPut<OverviewController>(
        () => OverviewController(service: Get.find()),
      );

      CartBindings().dependencies();
    });

    setUp(() {
      expect(Get.isPrepared<DarkThemeController>(), isFalse);
      expect(Get.isPrepared<IOverviewRepo>(), isFalse);
      expect(Get.isPrepared<IOverviewService>(), isFalse);
      expect(Get.isPrepared<OverviewController>(), isFalse);
      expect(Get.isPrepared<CartController>(), isFalse);

      expect(Get.isPrepared<IInventoryRepo>(), isFalse);
      expect(Get.isPrepared<IInventoryService>(), isFalse);
      expect(Get.isPrepared<InventoryController>(), isFalse);

      binding.builder();

      expect(Get.isPrepared<DarkThemeController>(), isTrue);
      expect(Get.isPrepared<IOverviewRepo>(), isTrue);
      expect(Get.isPrepared<IOverviewService>(), isTrue);
      expect(Get.isPrepared<OverviewController>(), isTrue);
      expect(Get.isPrepared<CartController>(), isTrue);

      expect(Get.isPrepared<IInventoryRepo>(), isTrue);
      expect(Get.isPrepared<IInventoryService>(), isTrue);
      expect(Get.isPrepared<InventoryController>(), isTrue);

      HttpOverrides.global = null;
      _seek = TestUtils();
    });

    void _checkRegistredInstances() {
      expect(Get.isRegistered<IOverviewRepo>(), isTrue);
      expect(Get.isRegistered<IOverviewService>(), isTrue);
      expect(Get.isRegistered<OverviewController>(), isTrue);
      expect(Get.isRegistered<CartController>(), isTrue);

      expect(Get.isRegistered<IInventoryRepo>(), isTrue);
      expect(Get.isRegistered<IInventoryService>(), isTrue);
      expect(Get.isRegistered<InventoryController>(), isTrue);
    }

    List<Product> _prods() {
      return Get.find<IOverviewService>().getLocalDataAllProducts();
    }

    tearDown(() {
      _seek = null;
      TestMethods.globalTearDown();
    });

    Future checkOverviewPage04ItemsAndOpenManagedProductsPagebyDrawer(
        WidgetTester tester) async {
      expect(_seek.type(OverviewGridItem), findsNWidgets(4));
      expect(ovViewScaffGlobalKey.currentState.isDrawerOpen, isFalse);
      ovViewScaffGlobalKey.currentState.openDrawer();
      await tester.pump();
      await tester.pump(_seek.delay(3));
      expect(ovViewScaffGlobalKey.currentState.isDrawerOpen, isTrue);
      await tester.tap(_seek.key(managedProductsDrawerOption));
      await tester.pump();
      await tester.pump(_seek.delay(1));
      expect(ovViewScaffGlobalKey.currentState.isDrawerOpen, isFalse);
    }

    void checkManagedProductsPage04Items() {
      expect(_seek.text(manProdPageTitle), findsOneWidget);
      expect(_seek.type(InventoryItem), findsNWidgets(4));
      expect(_seek.text(_prods()[0].title.toString()), findsOneWidget);
      expect(_seek.text(_prods()[1].title.toString()), findsOneWidget);
      expect(_seek.text(_prods()[2].title.toString()), findsOneWidget);
      expect(_seek.text(_prods()[3].title.toString()), findsOneWidget);
      expect(_seek.icon(iconAddProduct), findsNWidgets(1));
      expect(_seek.type(CircleAvatar), findsNWidgets(4));
    }

    testWidgets('Checking Listed Products in the page', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _checkRegistredInstances();

      await checkOverviewPage04ItemsAndOpenManagedProductsPagebyDrawer(tester);
      checkManagedProductsPage04Items();
    });

    testWidgets('Deleting a product', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _checkRegistredInstances();

      await checkOverviewPage04ItemsAndOpenManagedProductsPagebyDrawer(tester);
      checkManagedProductsPage04Items();

      var deleteButtonIconProduct1 =
          _seek.key('$INVENTORY_DELETEITEM_BUTTON_KEY${_prods()[0].id}');

      var titleProduct1 = _prods()[0].title.toString();

      // 1) Click DeleteButton in a Product
      //   -> Check the ManagedProductPage Items
      //   -> Confirm 'Deleted Product' absence
      await tester.tap(deleteButtonIconProduct1);
      await tester.pump();
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.type(InventoryItem), findsNWidgets(3));

      // 2) Click BackButton in ManagedProductPage
      //   -> Go to Overview Page
      //   -> Confirm 'Deleted Product' absence
      expect(_seek.type(BackButton), findsOneWidget);
      await tester.tap(_seek.type(BackButton));
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.type(OverviewGridItem), findsNWidgets(3));
      expect(_seek.text(titleProduct1), findsNothing);
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
          _seek.key('$INVENTORY_UPDATEITEM_BUTTON_KEY${_prods()[0].id}');
      var titleFieldKey = _seek.key(INVENTORY_ADDEDIT_FIELD_TITLE_KEY);
      var descFieldKey = _seek.key(INVENTORY_ADDEDIT_FIELD_DESCRIPT_KEY);
      var saveButtonKey = _seek.key(INVENTORY_ADDEDIT_SAVEBUTTON_KEY);
      var manProdAddEditPageTitle =
          _seek.text(INVENTORY_ADDEDIT_TITLEPAGE_EDIT);

      await checkOverviewPage04ItemsAndOpenManagedProductsPagebyDrawer(tester);
      checkManagedProductsPage04Items();

      // 1) Managed Products Page
      //   -> Click in 'First Product UpdateIcon'
      //   -> Open ManagedProductsAddEditPage(Product 01)
      await tester.tap(updateButtonProduct1);
      await tester.pump();
      await tester.pumpAndSettle(_seek.delay(1));

      // 2) ManagedProductsAddEditPage(Product 01)
      //   -> Checking the titlePage
      //   -> Page Form Fields
      expect(manProdAddEditPageTitle, findsOneWidget);
      expect(_seek.text(productTitle), findsOneWidget);
      expect(_seek.text(productPrice.toString()), findsOneWidget);
      expect(_seek.text(productDesc), findsOneWidget);
      expect(_seek.text(productUrl), findsOneWidget);

      // 3) Change the product
      //   -> Title
      //   -> Description
      await tester.tap(titleFieldKey);
      await tester.enterText(titleFieldKey, newTitle);
      await tester.tap(descFieldKey);
      await tester.enterText(descFieldKey, newDesc);
      await tester.pump();
      await tester.pump(_seek.delay(2));

      // 4) Checking
      //   -> New title
      //   -> New Desccription
      //   -> Other fields
      expect(_seek.text(newTitle), findsOneWidget);
      expect(_seek.text(productPrice.toString()), findsOneWidget);
      expect(_seek.text(newDesc), findsOneWidget);
      expect(_seek.text(productUrl), findsOneWidget);

      // 5) Save form
      //   -> Test INValidation messages
      //   -> Back to Managed Products Page
      await tester.tap(saveButtonKey);
      await tester.pump();
      await tester.pump(_seek.delay(4));
      expect(_seek.text(INVALID_TITLE_MSG), findsNothing);
      expect(_seek.text(INVALID_PRICE_MSG), findsNothing);
      expect(_seek.text(INVALID_DESCR_MSG), findsNothing);
      expect(_seek.text(INVALID_URL_MSG), findsNothing);

      // 6) Managed Products Page
      //   -> Checking the Updated Data
      expect(manProdAddEditPageTitle, findsNothing);
      expect(_seek.text(manProdPageTitle), findsOneWidget);
      expect(_seek.text(newTitle), findsOneWidget);

      // 7) Click BackButton in Managed Products Page
      //   -> Go to Overview Page
      //   -> Checking the Updated Data in OverviewPage
      expect(_seek.type(BackButton), findsOneWidget);
      await tester.tap(_seek.type(BackButton));
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
      expect(_seek.text(newTitle), findsOneWidget);
    });

    testWidgets('Refreshing page - Refresh-Indicator', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _checkRegistredInstances();

      await checkOverviewPage04ItemsAndOpenManagedProductsPagebyDrawer(tester);
      checkManagedProductsPage04Items();

      var dragInitialPointElement =
          _seek.key('$INVENTORY_ITEM_KEY${_prods()[0].id}');
      await tester.drag(dragInitialPointElement, Offset(0.0, -50.0));
      await tester.pump();
      await tester.pumpAndSettle(_seek.delay(1));

      expect(_seek.type(RefreshIndicator), findsNWidgets(1));
    });

    testWidgets('Testing Page BackButton', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _checkRegistredInstances();

      await checkOverviewPage04ItemsAndOpenManagedProductsPagebyDrawer(tester);
      checkManagedProductsPage04Items();

      expect(_seek.type(BackButton), findsOneWidget);
      await tester.tap(_seek.type(BackButton));
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
    });
  }
}
