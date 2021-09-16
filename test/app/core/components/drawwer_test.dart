import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/components/keys/progres_indicator_keys.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/components/drawwer.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/inventory/inventory.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/overview.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../config/bindings/components_test_bindings.dart';
import '../../../utils/finder_utils.dart';
import '../../../utils/tests_utils.dart';

class DrawwerTest {
  static void functional() {
    var _finder = Get.put(FinderUtils());
    var _testMethodsUtils = Get.put(TestsUtils());

    setUp(() {
      ComponentsTestBindings().bindingsBuilderMockedRepo();
    });

    List<Product> _products() {
      return Get.find<IOverviewService>().getLocalDataAllProducts();
    }

    testWidgets('Checking Overview BEFORE open Drawer', (tester) async {
      await tester.pumpWidget(AppDriver());

      expect(_finder.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);
      expect(_finder.text(NO_PRODUCTS_FOUND_YET), findsNothing);

      await tester.pump();
      await tester.pump(_testMethodsUtils.delay(3));
      expect(_finder.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
      expect(_finder.text(_products()[0].title.toString()), findsOneWidget);
      expect(_finder.text(_products()[1].title.toString()), findsOneWidget);
      expect(_finder.text(_products()[2].title.toString()), findsOneWidget);
      expect(_finder.text(_products()[3].title.toString()), findsOneWidget);
      expect(_finder.iconType(IconButton, Icons.favorite), findsOneWidget);
      expect(_finder.iconType(IconButton, Icons.favorite_border), findsNWidgets(3));
      expect(_finder.iconType(IconButton, Icons.shopping_cart), findsNWidgets(5));
      expect(_finder.iconData(Icons.more_vert), findsOneWidget);
      expect(_finder.key(K_DRW_APPBAR_BTN), findsOneWidget);
    });

    testWidgets('Tapping Drawer', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var scaffoldKey = DRAWWER_SCAFFOLD_GLOBALKEY;
      var scaffState = scaffoldKey.currentState!;
      var titleDrawer = DRAWER_COMPONENT_TITLE_APPBAR;

      // Tapping three times
      for (var counter = 0; counter <= 2; counter++) {
        expect(_finder.text(titleDrawer), findsNothing);
        expect(scaffState.isDrawerOpen, isFalse);
        scaffState.openDrawer();
        await tester.pump();
        await tester.pump(_testMethodsUtils.delay(1));
        expect(scaffState.isDrawerOpen, isTrue);
        expect(_finder.text(titleDrawer), findsOneWidget);
        await tester.tapAt(const Offset(750.0, 100.0)); // on the mask
        await tester.pump();
        await tester.pump(_testMethodsUtils.delay(1)); // animation done
        expect(_finder.text(titleDrawer), findsNothing);
        expect(scaffState.isDrawerOpen, isFalse);
      }
    });

    testWidgets('Tapping Drawer, closing tapping outside', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var scaffoldKey = DRAWWER_SCAFFOLD_GLOBALKEY;
      var scaffState = scaffoldKey.currentState!;
      var titleDrawer = DRAWER_COMPONENT_TITLE_APPBAR;

      expect(_finder.text(titleDrawer), findsNothing);
      expect(scaffState.isDrawerOpen, isFalse);
      scaffState.openDrawer();
      await tester.pump();
      await tester.pump(_testMethodsUtils.delay(3));
      expect(scaffState.isDrawerOpen, isTrue);
      expect(_finder.text(titleDrawer), findsOneWidget);
      await tester.tapAt(const Offset(750.0, 100.0)); // on the mask
      await tester.pump();
      await tester.pump(_testMethodsUtils.delay(3)); // animation done
      expect(_finder.text(titleDrawer), findsNothing);
    });

    testWidgets('Tapping Two Drawer Options', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var scaffoldKey = DRAWWER_SCAFFOLD_GLOBALKEY;
      var scaffState = scaffoldKey.currentState!;
      var titleDrawer = DRAWER_COMPONENT_TITLE_APPBAR;
      var ovViewPageTitle = OVERVIEW_TITLE_PAGE_ALL;
      var manProdPageTitle = INVENTORY_PAGE_TITLE;
      var manProdDrawerOption = _finder.key(DRAWER_INVENTORY_OPTION_KEY);
      var ovViewDrawerOption = _finder.key(DRAWER_OVERVIEW_OPTION_KEY);

      for (var counter = 1; counter <= 2; counter++) {
        expect(_finder.text(titleDrawer), findsNothing);
        scaffState.openDrawer();
        await tester.pump();
        await tester.pump(_testMethodsUtils.delay(3));
        expect(_finder.text(titleDrawer), findsOneWidget);
        counter == 1
            ? await tester.tap(ovViewDrawerOption)
            : await tester.tap(manProdDrawerOption);
        await tester.pump();
        await tester.pump(_testMethodsUtils.delay(3));
        counter == 1
            ? expect(_finder.text(ovViewPageTitle), findsOneWidget)
            : expect(_finder.text(manProdPageTitle), findsOneWidget);
      }
    });
  }
}
