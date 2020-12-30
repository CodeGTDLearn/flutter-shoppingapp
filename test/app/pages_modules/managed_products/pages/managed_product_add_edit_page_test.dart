import 'dart:io';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/theme/dark_theme_controller.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/managed_products/managed_product_edit.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/managed_products/managed_products.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/pages_generic_components/drawwer.dart';
import 'package:shopingapp/app/pages_modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/pages_modules/cart/core/cart_bindings.dart';
import 'package:shopingapp/app/pages_modules/custom_widgets/core/keys/custom_circ_progr_indicator_keys.dart';
import 'package:shopingapp/app/pages_modules/custom_widgets/core/keys/custom_drawer_widgets_keys.dart';
import 'package:shopingapp/app/pages_modules/custom_widgets/core/keys/custom_snackbar_widgets_keys.dart';
import 'package:shopingapp/app/pages_modules/managed_products/controller/managed_products_controller.dart';
import 'package:shopingapp/app/pages_modules/managed_products/core/managed_products_widget_keys.dart';
import 'package:shopingapp/app/pages_modules/managed_products/core/messages/field_form_validation_provided.dart';
import 'package:shopingapp/app/pages_modules/managed_products/repo/i_managed_products_repo.dart';
import 'package:shopingapp/app/pages_modules/managed_products/service/i_managed_products_service.dart';
import 'package:shopingapp/app/pages_modules/managed_products/service/managed_products_service.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/pages_modules/overview/service/overview_service.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../../test_utils/global_methods.dart';
import '../../../../test_utils/utils.dart';
import '../../overview/repo/overview_repo_mocks.dart';
import '../repo/managed_products_repo_mocks.dart';

class ManagedProductsAddEditPageTest {
  static void functional() {
    var scaffoldKey = OVERVIEW_PAGE_MAIN_SCAFFOLD_KEY;
    var titleDrawer = DRAWER_COMPONENT_TITLE_APPBAR;
    var drawerMenuOption = DRAWWER_MANAGED_PRODUCTS_MENU_OPTION;
    var addButton = MANAGED_PRODUCTS_ADDEDIT_APPBAR_ADD_BUTTON_KEY;
    var saveButton = MANAGED_PRODUCTS_ADDEDIT_APPBAR_SAVE_BUTTON_KEY;
    var manProdPageTitle = MANAGED_PRODUCTS_PAGE_TITLE;
    var manProdAddEditPageTitle = MANAGED_PRODUCTS_ADDEDIT_PAGE_ADD;

    var fldTitle = MANAGED_PRODUCTS_ADDEDIT_FIELD_TITLE;
    var fldPrice = MANAGED_PRODUCTS_ADDEDIT_FIELD_PRICE;
    var fldDescr = MANAGED_PRODUCTS_ADDEDIT_FIELD_DESCRIPT;
    var fldImgUrl = MANAGED_PRODUCTS_ADDEDIT_FIELD_IMAGE_URL;
    var fldImgTitle = MANAGED_PRODUCTS_ADDEDIT_IMAGE_TITLE;

    var keyFldTitle = MANAGED_PRODUCTS_ADDEDIT_FIELD_TITLE_KEY;
    var keyFldPrice = MANAGED_PRODUCTS_ADDEDIT_FIELD_PRICE_KEY;
    var keyFldDescr = MANAGED_PRODUCTS_ADDEDIT_FIELD_DESCRIPT_KEY;
    var keyFldImgUrl = MANAGED_PRODUCTS_ADDEDIT_FIELD_URL_KEY;

    var fakerFldTitle;
    var fakerFldPrice;
    var fakerFldDescr;
    var fakerFldImgUrl;

    Utils _seek;

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
      _seek = Utils();
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

    tearDown(() {
      GlobalMethods.tearDown();
      _seek = null;
    });

    Future _openDrawerAndManagedProductsAddEditPage(tester) async {
      expect(_seek.text(titleDrawer), findsNothing);
      scaffoldKey.currentState.openDrawer();
      await tester.pump();
      await tester.pump(_seek.delay(1));
      await tester.tap(_seek.key(drawerMenuOption));
      await tester.pump();
      await tester.pump(_seek.delay(1));
      expect(_seek.text(manProdPageTitle), findsOneWidget);
      await tester.tap(_seek.key(addButton));
      await tester.pump();
      await tester.pump(_seek.delay(1));
      expect(_seek.text(manProdAddEditPageTitle), findsOneWidget);
    }

    void _loadFieldsVariablesTestingWithFakeData() {
      // fakerFldTitle = Faker().food.dish();
      fakerFldTitle = Faker().randomGenerator.string(10, min: 5);
      fakerFldPrice =
          Faker().randomGenerator.decimal(min: 20).toPrecision(2).toString();
      fakerFldDescr = Faker().randomGenerator.string(30, min: 10);
      fakerFldImgUrl =
          "https://images.freeimages.com/images/large-previews/eae/clothes-3-1466560.jpg";
    }

    testWidgets('Saving a product < XXXXXXXXXXXXX', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var customCircProgrIndic = _seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY);
      var snackbartext1 = _seek.text("message");

      _loadFieldsVariablesTestingWithFakeData();

      expect(_seek.text(manProdAddEditPageTitle), findsNothing);
      await _openDrawerAndManagedProductsAddEditPage(tester);

      await tester.enterText(_seek.key(keyFldTitle), fakerFldTitle);
      await tester.enterText(_seek.key(keyFldPrice), fakerFldPrice);
      await tester.enterText(_seek.key(keyFldDescr), fakerFldDescr);
      await tester.enterText(_seek.key(keyFldImgUrl), fakerFldImgUrl);

      await tester.pump();
      await tester.pump(_seek.delay(2));
      expect(_seek.text(manProdAddEditPageTitle), findsOneWidget);

      await tester.tap(_seek.key(saveButton));
      await tester.pump();
      await tester.pump(_seek.delay(1));

      expect(_seek.text(manProdAddEditPageTitle), findsOneWidget);
      expect(customCircProgrIndic, findsOneWidget);
      // expect(_seek.text(manProdPageTitle), findsOneWidget);
      // expect(_seek.text(ERROR_TRY_AGAIN_LATER), findsOneWidget);
      // await tester.pump(_seek.delay(1));
      // expect(snackbartext1, findsOneWidget);
    });

    testWidgets('Open Page', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      await _openDrawerAndManagedProductsAddEditPage(tester);

      expect(_seek.text(fldTitle), findsOneWidget);
      expect(_seek.text(fldPrice), findsOneWidget);
      expect(_seek.text(fldDescr), findsOneWidget);
      expect(_seek.text(fldImgUrl), findsOneWidget);
      expect(_seek.text(fldImgTitle), findsOneWidget);
    });

    testWidgets('Open Page - Failing - No products registred',
            (tester)
    async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var customCircProgrIndic = _seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY);

      expect(_seek.text(titleDrawer), findsNothing);
      scaffoldKey.currentState.openDrawer();
      await tester.pump();
      await tester.pump(_seek.delay(1));
      await tester.tap(_seek.key(drawerMenuOption));
      await tester.pump();
      await tester.pump(_seek.delay(2));

      //<<<<<<<<<existe produtos, pois o RepoMock esta carregando produtos
      // mockados e criados no mock, tem-se que mockas novamente "sem
      // produtos" par afuncionar
      expect(_seek.text(manProdPageTitle), findsNothing);
      // expect(customCircProgrIndic, findsOneWidget);
    });

    testWidgets('Fullfill fields + Check previewImageUrl', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      _loadFieldsVariablesTestingWithFakeData();

      await _openDrawerAndManagedProductsAddEditPage(tester);

      await tester.enterText(_seek.key(keyFldTitle), fakerFldTitle);
      await tester.enterText(_seek.key(keyFldPrice), fakerFldPrice);
      await tester.enterText(_seek.key(keyFldDescr), fakerFldDescr);
      await tester.enterText(_seek.key(keyFldImgUrl), fakerFldImgUrl);

      await tester.pump();
      await tester.pump(_seek.delay(2));

      _seek.imagesTotal(0);
      await tester.tap(_seek.key(keyFldDescr));
      await tester.pump();
      await tester.pump(_seek.delay(2));
      _seek.imagesTotal(1);
    });

    testWidgets('Test Fullfill Validation fields', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      _loadFieldsVariablesTestingWithFakeData();

      await _openDrawerAndManagedProductsAddEditPage(tester);

      //minimal characters not allowed
      await tester.enterText(_seek.key(keyFldTitle), "d");
      await tester.enterText(_seek.key(keyFldPrice), "d");
      await tester.enterText(_seek.key(keyFldDescr), "d");
      await tester.enterText(_seek.key(keyFldImgUrl), "d");

      await tester.tap(_seek.key(saveButton));
      await tester.pump();
      await tester.pump(_seek.delay(1));

      expect(_seek.text(INVALID_TITLE_MSG), findsOneWidget);
      expect(_seek.text(INVALID_PRICE_MSG), findsOneWidget);
      expect(_seek.text(INVALID_DESCR_MSG), findsOneWidget);
      expect(_seek.text(INVALID_URL_MSG), findsOneWidget);

      await tester.enterText(_seek.key(keyFldTitle), fakerFldTitle);
      await tester.enterText(_seek.key(keyFldPrice), fakerFldPrice);
      await tester.enterText(_seek.key(keyFldDescr), fakerFldDescr);
      await tester.enterText(_seek.key(keyFldImgUrl), fakerFldImgUrl);

      await tester.tap(_seek.key(saveButton));
      await tester.pump();
    });

    testWidgets('Testing Page BackButton', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      _loadFieldsVariablesTestingWithFakeData();

      await _openDrawerAndManagedProductsAddEditPage(tester);

      expect(_seek.type(BackButton), findsOneWidget);
      await tester.pump();
      await tester.tap(_seek.type(BackButton));
      await tester.pump();
      await tester.pump(_seek.delay(2));
      expect(_seek.text(manProdPageTitle), findsOneWidget);
    });
  }
}
