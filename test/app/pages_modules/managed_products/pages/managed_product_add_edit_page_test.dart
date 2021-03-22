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
import 'package:shopingapp/app/pages_modules/managed_products/components/managed_product_item.dart';
import 'package:shopingapp/app/pages_modules/managed_products/controller/managed_products_controller.dart';
import 'package:shopingapp/app/pages_modules/managed_products/core/managed_products_widget_keys.dart';
import 'package:shopingapp/app/pages_modules/managed_products/core/messages/field_form_validation_provided.dart';
import 'package:shopingapp/app/pages_modules/managed_products/repo/i_managed_products_repo.dart';
import 'package:shopingapp/app/pages_modules/managed_products/service/i_managed_products_service.dart';
import 'package:shopingapp/app/pages_modules/managed_products/service/managed_products_service.dart';
import 'package:shopingapp/app/pages_modules/overview/components/overview_grid_item.dart';
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

class ManagedProductsAddEditPageTest {
  static void functional() {
    var _seek = TestUtils();

    var drawerTitle = _seek.text(DRAWER_COMPONENT_TITLE_APPBAR);
    var manProdPageTitle = _seek.text(MANAGED_PRODUCTS_PAGE_TITLE);
    var manProdAddEditPageTitle =
        _seek.text(MANAGED_PRODUCTS_ADDEDIT_TITLEPAGE_ADD);

    var fldTitle = _seek.text(MANAGED_PRODUCTS_ADDEDIT_FIELD_TITLE);
    var fldPrice = _seek.text(MANAGED_PRODUCTS_ADDEDIT_FIELD_PRICE);
    var fldDescr = _seek.text(MANAGED_PRODUCTS_ADDEDIT_FIELD_DESCRIPT);
    var fldImgUrl = _seek.text(MANAGED_PRODUCTS_ADDEDIT_FIELD_IMAGE_URL);
    var fldImgTitle = _seek.text(MANAGED_PRODUCTS_ADDEDIT_IMAGE_TITLE);

    var ovViewScaffoldKey = OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY;
    var manProdScaffoldKey = MANAGED_PRODUCTS_PAGE_SCAFFOLD_GLOBALKEY;
    var drwMenuOptionKey1 = _seek.key(DRAWWER_OVERVIEW_PRODUCTS_MENU_OPTION);
    var drwMenuOptionKey2 = _seek.key(DRAWWER_MANAGED_PRODUCTS_MENU_OPTION);
    var addButtonKey = _seek.key(MANAGED_PRODUCTS_APPBAR_ADDBUTTON_KEY);
    var saveButtonKey = _seek.key(MANAGED_PRODUCTS_ADDEDIT_SAVEBUTTON_KEY);
    var fldTitleKey = _seek.key(MANAGED_PRODUCTS_ADDEDIT_FIELD_TITLE_KEY);
    var fldPriceKey = _seek.key(MANAGED_PRODUCTS_ADDEDIT_FIELD_PRICE_KEY);
    var fldDescrKey = _seek.key(MANAGED_PRODUCTS_ADDEDIT_FIELD_DESCRIPT_KEY);
    var fldImgUrlKey = _seek.key(MANAGED_PRODUCTS_ADDEDIT_FIELD_URL_KEY);
    var customCircProgrIndicKey = _seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY);

    var fakeTitle;
    var fakePrice;
    var fakeDesc;
    var fakeImgUrl;
    var invalidText;

    var _binding;

    void _getBinding(IManagedProductsRepo mock) {
      Get.reset();
      _binding = BindingsBuilder(() {
        Get.lazyPut<DarkThemeController>(() => DarkThemeController());

        // Get.lazyPut<IManagedProductsRepo>(() => ManagedProductsMockRepo());
        Get.lazyPut<IManagedProductsRepo>(() => mock);

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
    }

    setUp(() {
      expect(Get.isPrepared<IOverviewRepo>(), isFalse);
      expect(Get.isPrepared<IOverviewService>(), isFalse);
      expect(Get.isPrepared<OverviewController>(), isFalse);
      expect(Get.isPrepared<CartController>(), isFalse);

      expect(Get.isPrepared<IManagedProductsRepo>(), isFalse);
      expect(Get.isPrepared<IManagedProductsService>(), isFalse);
      expect(Get.isPrepared<ManagedProductsController>(), isFalse);

      _getBinding(ManagedProductsMockRepo());
      _binding.builder();

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

    tearDown(() {
      CustomTestMethods.globalTearDown();
      _seek = null;
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

    void _expectTestingPageFieldsExistence() {
      expect(fldTitle, findsOneWidget);
      expect(fldPrice, findsOneWidget);
      expect(fldDescr, findsOneWidget);
      expect(fldImgUrl, findsOneWidget);
      expect(fldImgTitle, findsOneWidget);
    }

    Future _openAndTestManagedProductsAddEditPage(tester) async {
      //a) Click in drawer
      //   -> Check the Total of 04 OverviewGridItem in 'Overview Page'
      //   -> Select Managed Product Option
      //      -> Open Managed Products Page
      expect(_seek.type(OverviewGridItem), findsNWidgets(4));
      expect(ovViewScaffoldKey.currentState.isDrawerOpen, isFalse);
      ovViewScaffoldKey.currentState.openDrawer();
      await tester.pump();
      await tester.pump(_seek.delay(1));
      expect(ovViewScaffoldKey.currentState.isDrawerOpen, isTrue);
      expect(manProdPageTitle, findsNothing);
      await tester.tap(drwMenuOptionKey1);
      await tester.pump();
      await tester.pump(_seek.delay(1));


      //b) Managed Products Page:
      //   -> Find 04 ManagedProductItem
      //   -> Click AddButton (Add a New Product)
      //      -> Open ManProductsAddEditPage (To enter New Product Features)
      expect(ovViewScaffoldKey.currentState.isDrawerOpen, isFalse);
      expect(drawerTitle, findsNothing);
      expect(manProdPageTitle, findsOneWidget);
      expect(_seek.type(ManagedProductItem), findsNWidgets(4));
      expect(manProdAddEditPageTitle, findsNothing);
      await tester.tap(addButtonKey);
      await tester.pump();
      await tester.pump(_seek.delay(1));
      expect(manProdPageTitle, findsNothing);
      expect(manProdAddEditPageTitle, findsOneWidget);
    }

    void _createFakeDataAndLoadThoseInTestsVariables() {
      invalidText = "d";
      // fakeTitle = Faker().randomGenerator.string(10, min: 5);
      fakeTitle = "xxxxxx";
      fakePrice =
          Faker().randomGenerator.decimal(min: 20).toPrecision(2).toString();
      // fakeDesc = Faker().randomGenerator.string(30, min: 10);
      fakeDesc = "xxxxxxxxxxxxxx";
      fakeImgUrl =
          "https://images.freeimages.com/images/large-previews/eae/clothes-3-1466560.jpg";
    }

    Future _loadFormFields(WidgetTester tester, String title, String price,
        String descr, String imgUrl) async {
      await tester.enterText(fldTitleKey, title);
      await tester.enterText(fldPriceKey, price);
      await tester.enterText(fldDescrKey, descr);
      await tester.enterText(fldImgUrlKey, imgUrl);
    }

    void _expectTestingINValidationMessages(Matcher matcher) {
      expect(_seek.text(INVALID_TITLE_MSG), matcher);
      expect(_seek.text(INVALID_PRICE_MSG), matcher);
      expect(_seek.text(INVALID_DESCR_MSG), matcher);
      expect(_seek.text(INVALID_URL_MSG), matcher);
    }

    testWidgets('Adding a product', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      _createFakeDataAndLoadThoseInTestsVariables();

      await _openAndTestManagedProductsAddEditPage(tester);
      await tester.pump();
      await tester.pump(_seek.delay(1));
      expect(manProdAddEditPageTitle, findsOneWidget);

      await _loadFormFields(tester, fakeTitle, fakePrice, fakeDesc, fakeImgUrl);
      await tester.pump();
      await tester.pump(_seek.delay(2));

      expect(manProdAddEditPageTitle, findsOneWidget);
      await tester.tap(saveButtonKey);
      await tester.pump();
      await tester.pump(_seek.delay(3));
      expect(manProdAddEditPageTitle, findsNothing);

      expect(manProdPageTitle, findsOneWidget);
      expect(_seek.type(ManagedProductItem), findsNWidgets(5));

      expect(ovViewScaffoldKey.currentState.isDrawerOpen, isFalse);
      ovViewScaffoldKey.currentState.openDrawer();
      await tester.pump();
      await tester.pump(_seek.delay(1));
      expect(ovViewScaffoldKey.currentState.isDrawerOpen, isTrue);
      //TODO: TESTE QUE DEVE SER INVESTIGADO - GLOBAL KEY DUPLICATION!!!!
      // await tester.tap(drwMenuOptionKey2);
      // await tester.pump();
      // await tester.pump(_seek.delay(1));
      // expect(_seek.type(OverviewGridItem), findsNWidgets(5));
    });

    testWidgets('Open Managed Product AddEdit Page', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      await _openAndTestManagedProductsAddEditPage(tester);

      _expectTestingPageFieldsExistence();
    });

    testWidgets('Fullfilling fields with previewImageUrl', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      _createFakeDataAndLoadThoseInTestsVariables();

      await _openAndTestManagedProductsAddEditPage(tester);

      await _loadFormFields(tester, fakeTitle, fakePrice, fakeDesc, fakeImgUrl);

      await tester.pump();
      await tester.pump(_seek.delay(2));

      _seek.imagesTotal(0);
      await tester.tap(fldDescrKey);
      await tester.pump();
      await tester.pump(_seek.delay(2));
      _seek.imagesTotal(1);

      await tester.tap(saveButtonKey);
      await tester.pump();
      await tester.pump(_seek.delay(3));

      _expectTestingINValidationMessages(findsNothing);
    });

    testWidgets('Fullfilling fields testing INValidation', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      _createFakeDataAndLoadThoseInTestsVariables();

      await _openAndTestManagedProductsAddEditPage(tester);

      await _loadFormFields(
          tester, invalidText, invalidText, invalidText, invalidText);

      await tester.tap(saveButtonKey);
      await tester.pump();
      await tester.pump(_seek.delay(1));

      _expectTestingINValidationMessages(findsOneWidget);

      expect(manProdAddEditPageTitle, findsOneWidget);
    });

    testWidgets('Testing Page BackButton', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      _createFakeDataAndLoadThoseInTestsVariables();

      await _openAndTestManagedProductsAddEditPage(tester);

      expect(_seek.type(BackButton), findsOneWidget);
      await tester.pump();
      await tester.tap(_seek.type(BackButton));
      await tester.pump();
      await tester.pump(_seek.delay(2));
      expect(manProdPageTitle, findsOneWidget);
    });

    testWidgets('Open Page with NO products in DB', (tester) async {
      _getBinding(ManagedProductsMockRepoFail());
      _binding.builder();

      await tester.pumpWidget(AppDriver());
      await tester.pump();

      _isInstancesRegistred();

      expect(drawerTitle, findsNothing);
      ovViewScaffoldKey.currentState.openDrawer();
      await tester.pump();
      await tester.pump(_seek.delay(1));
      expect(drawerTitle, findsOneWidget);

      await tester.tap(drwMenuOptionKey1);
      await tester.pump();
      await tester.pump(_seek.delay(1));
      expect(manProdPageTitle, findsOneWidget);
      expect(customCircProgrIndicKey, findsOneWidget);

      await tester.tap(addButtonKey);
      await tester.pump();
      await tester.pump(_seek.delay(1));
      expect(manProdAddEditPageTitle, findsOneWidget);

      _expectTestingPageFieldsExistence();
    });
  }
}
