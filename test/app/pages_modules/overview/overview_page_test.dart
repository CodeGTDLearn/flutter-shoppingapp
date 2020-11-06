import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/theme/dark_theme_controller.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages/snackbars.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/overview.dart';
import 'package:shopingapp/app/pages_modules/overview/components/overview_grid_item.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/pages_modules/overview/service/overview_service.dart';
import 'package:shopingapp/app_driver.dart';

import 'repo/overview_repo_mocks.dart';

// void main() {
class OverviewPageTest {
  static void WidgetIntegrationTests() {
    setUpAll(() => HttpOverrides.global = null);

    tearDownAll(Get.reset);

    final binding = BindingsBuilder(() {
      Get.lazyPut<DarkThemeController>(() => DarkThemeController());
      Get.lazyPut<IOverviewRepo>(() => MockRepo());
      Get.lazyPut<IOverviewService>(
          () => OverviewService(repo: Get.find<IOverviewRepo>()));
      Get.lazyPut<OverviewController>(
          () => OverviewController(service: Get.find<IOverviewService>()));
    });

    Finder findKey(String key) {
      return find.byKey(ValueKey(key));
    }

    test('1 - Test Binding Instantiating', () {
      expect(Get.isPrepared<IOverviewRepo>(), false);
      expect(Get.isPrepared<IOverviewService>(), false);
      expect(Get.isPrepared<OverviewController>(), false);

      binding.builder();

      expect(Get.isPrepared<IOverviewRepo>(), true);
      expect(Get.isPrepared<IOverviewService>(), true);
      expect(Get.isPrepared<OverviewController>(), true);
    });

    testWidgets('2 - Checking Starting Elements', (WidgetTester tester) async {
      await tester.pumpWidget(AppDriver());

      expect(Get.isRegistered<IOverviewRepo>(), true);
      expect(Get.isRegistered<IOverviewService>(), true);
      expect(Get.isRegistered<OverviewController>(), true);

      var products = Get.find<IOverviewService>().localDataAllProducts;

      await tester.pump();

      expect(find.text(OVERVIEW_TITLE_ALL_APPBAR), findsOneWidget);
      expect(find.text(products[0].title.toString()), findsOneWidget);
      expect(find.text(products[1].title.toString()), findsOneWidget);
      expect(find.text(products[2].title.toString()), findsOneWidget);
      expect(find.text(products[3].title.toString()), findsOneWidget);
      expect(find.widgetWithIcon(IconButton, Icons.favorite), findsOneWidget);
      expect(find.widgetWithIcon(IconButton, Icons.favorite_border),
          findsNWidgets(3));
      expect(find.widgetWithIcon(IconButton, Icons.shopping_cart),
          findsNWidgets(5));
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('3 - Toggling favorites', (WidgetTester tester) async {
      await tester.pumpWidget(AppDriver());

      // var key1 = find.descendant(
      //     of: find.byKey(Key("cont_0")),
      //     matching: find.byKey(Key('$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\_0')) );

      var key1 = find.descendant(
          of: find.byKey(Key("cont_0")), matching: find.byType(IconButton));

      // final Container gridBuilder = Container(
      //   key: Key('gridView'),
      //   child: GridView.builder(
      //     itemCount: movies.length,
      //     key: GlobalKey(),
      //   ),
      // );
      // find.descendant(of: find.byKey(Key('gridView')),
      // matching: find.byType(GridView));

      // var key1 = find.byWidgetPredicate((widget) =>
      //     widget is IconButton &&
      //     widget.key == ValueKey('$OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY\_0'));
      // expect(key1, findsOneWidget);

      var key2 = findKey(FLUSH_NOTIFIER_SIMPLE_KEY);

      // await tester.tap(key1);

      // tester
      //     .tap(key1)
      //     .then((value) => tester.pumpAndSettle(Duration(seconds: 1)))
      //     .then((value) => expect(key2, findsOneWidget))
      //     .then((value) =>
      //     expect(find.text(SUCESS_PRODUCTS_UPDATING), findsOneWidget));
    });
  }
}
