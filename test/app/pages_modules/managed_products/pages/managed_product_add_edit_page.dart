import 'dart:io';

import 'package:faker/faker.dart';
import 'package:faker/faker.dart';
import 'package:faker/faker.dart';
import 'package:faker/faker.dart';
import 'package:faker/faker.dart';
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
import 'package:shopingapp/app/pages_modules/custom_widgets/core/custom_drawer_widgets_keys.dart';
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

import '../../../../test_utils/global_test_methods.dart';
import '../../../../test_utils/utils.dart';
import '../../overview/repo/overview_repo_mocks.dart';
import '../repo/managed_products_repo_mocks.dart';

class ManagedProductsAddEditPageTest {
  static void functional() {
    Utils seek;

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
      seek = Utils();
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

    List<Product> _products() {
      return Get.find<IOverviewService>().localDataAllProducts;
    }

    tearDown(() {
      GlobalTestMethods.tearDown();
      seek = null;
    });

    var scaffoldKey = OVERVIEW_PAGE_MAIN_SCAFFOLD_KEY;
    var titleDrawer = DRAWER_COMPONENT_TITLE_APPBAR;
    var drawerMenuOption = DRAWWER_MANAGED_PRODUCTS_MENU_OPTION;
    var addButton = MANAGED_PRODUCTS_APPBAR_ADD_BUTTON;
    var saveButton = MANAGED_PRODUCTS_ADD_EDIT_APPBAR_SAVE_BUTTON;
    // var formKey = MANAGED_PRODUCTS_ADD_EDIT_FORM_GLOBAL_KEY;
    var manProdPageTitle = MANAGED_PRODUCTS_TITLE_APPBAR;
    var addEditPageTitle = MANAGED_PRODUCTS_EDIT_LABEL_ADD_APPBAR;

    var fldTitle = MANAGED_PRODUCTS_EDIT_FIELD_TITLE;
    var fldPrice = MANAGED_PRODUCTS_EDIT_FIELD_PRICE;
    var fldDescr = MANAGED_PRODUCTS_EDIT_FIELD_DESCRIPT;
    var fldImgUrl = MANAGED_PRODUCTS_EDIT_FIELD_IMAGE_URL;
    var fldImgTitle = MANAGED_PRODUCTS_EDIT_IMAGE_TITLE;

    var keyFldTitle = MANAGED_PRODUCTS_ADD_EDIT_FIELD_TITLE;
    var keyFldPrice = MANAGED_PRODUCTS_ADD_EDIT_FIELD_PRICE;
    var keyFldDescr = MANAGED_PRODUCTS_ADD_EDIT_FIELD_DESCRIPTION;
    var keyFldImgUrl = MANAGED_PRODUCTS_ADD_EDIT_FIELD_URL;
    var keyFldImgTitle = MANAGED_PRODUCTS_EDIT_IMAGE_TITLE;

    Future _openDrawerAndManagedProductsAddEditPage(WidgetTester tester) async {
      expect(seek.text(titleDrawer), findsNothing);
      scaffoldKey.currentState.openDrawer();
      await tester.pump();
      await tester.pump(seek.delay(1));
      await tester.tap(seek.key(drawerMenuOption));
      await tester.pump();
      await tester.pump(seek.delay(1));
      expect(seek.text(manProdPageTitle), findsOneWidget);
      await tester.tap(seek.key(addButton));
      await tester.pump();
      await tester.pump(seek.delay(1));
      expect(seek.text(addEditPageTitle), findsOneWidget);
    }

    testWidgets('Checking ManagedProductPage elements', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      await _openDrawerAndManagedProductsAddEditPage(tester);

      expect(seek.text(fldTitle), findsOneWidget);
      expect(seek.text(fldPrice), findsOneWidget);
      expect(seek.text(fldDescr), findsOneWidget);
      expect(seek.text(fldImgUrl), findsOneWidget);
      expect(seek.text(fldImgTitle), findsOneWidget);
    });

    testWidgets('Adding a product', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var fakerFldTitle = Faker().food.dish();
      var fakerFldPrice = Faker().randomGenerator.decimal().toString();
      var fakerFldDescr = Faker().food.cuisine();
      var fakerFldImgUrl = Faker().internet.httpUrl();
      var fakerFldImgTitle = Faker().food.restaurant();

      await _openDrawerAndManagedProductsAddEditPage(tester);

      expect(seek.key(keyFldTitle), isNull);
      expect(seek.key(keyFldPrice), isNull);
      expect(seek.key(keyFldDescr), isNull);
      expect(seek.key(keyFldImgUrl), isNull);
      // expect(seek.key(keyFldImgTitle), isNull);

      await tester.enterText(seek.key(keyFldTitle), fakerFldTitle);
      await tester.enterText(seek.key(keyFldPrice), fakerFldPrice);
      await tester.enterText(seek.key(keyFldDescr), fakerFldDescr);
      await tester.enterText(seek.key(keyFldImgUrl), fakerFldImgUrl);
      // await tester.enterText(seek.key(keyFldImgTitle), fakerFldImgTitle);

      // formKey.currentState.save();

      await tester.tap(seek.key(saveButton));
      await tester.pump();
      await tester.pump(seek.delay(2));
      expect(seek.text(manProdPageTitle), findsOneWidget);
    });
  }
}
