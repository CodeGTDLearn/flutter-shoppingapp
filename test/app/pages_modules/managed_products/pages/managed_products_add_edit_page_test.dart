import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:shopingapp/app/core/properties/theme/dark_theme_controller.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/overview.dart';
import 'package:shopingapp/app/pages_modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/pages_modules/cart/core/cart_bindings.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/pages_modules/overview/service/overview_service.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../../test_utils/test_utils.dart';
import '../../overview/repo/overview_repo_mocks.dart';


class ManagedProductsAddEditPageTest {
  static void functional() {
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
    });

    tearDown(() {
      Get.reset;
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

    testWidgets('Checking OverviewPage Elements displayed', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var products = _products();
      await tester.pump();

      expect(TestUtils.text(OVERVIEW_TITLE_ALL_APPBAR), findsOneWidget);
      expect(TestUtils.text(_products()[0].title.toString()), findsOneWidget);
      expect(TestUtils.text(_products()[1].title.toString()), findsOneWidget);
      expect(TestUtils.text(_products()[2].title.toString()), findsOneWidget);
      expect(TestUtils.text(_products()[3].title.toString()), findsOneWidget);

      expect(TestUtils.type(IconButton, Icons.favorite), findsOneWidget);
      expect(TestUtils.type(IconButton, Icons.favorite_border), findsNWidgets(3));
      expect(TestUtils.type(IconButton, Icons.shopping_cart), findsNWidgets(5));

      expect(TestUtils.icon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('Clicking Drawer Page',
        (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var keyProduct1 = TestUtils.key("$OVERVIEW_ITEM_DETAILS_PAGE_KEY\0");
      var keyDrawer = TestUtils.key("$OVERVIEW_ITEM_DETAILS_PAGE_KEY"
          "\0");

          // @formatter:off
      tester
          .tap(keyProduct1)
          .then((value) => tester.pumpAndSettle(TestUtils.delay(1)))
          .then((value) {
              expect(TestUtils.text(_products()[0].title.toString()), findsOneWidget);
              expect(TestUtils.text('\$${_products()[0].price}'),findsOneWidget);
              expect(TestUtils.text(_products()[0].description.toString()), findsOneWidget);
          });
      // @formatter:on
        });

    testWidgets(
        'Clicking Product 01 + Show Details(image) Page', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();
      _isInstancesRegistred();

      var keyProduct1 = TestUtils.key("$OVERVIEW_ITEM_DETAILS_PAGE_KEY\0");

      await tester.tap(keyProduct1);
      await tester.pumpAndSettle(TestUtils.delay(1)); // check if the page has
      // changed
      expect(TestUtils.text(_products()[0].title.toString()), findsOneWidget);
      provideMockedNetworkImages(() async {
        expect(find.byType(Image), findsOneWidget);
      });
    });
  }
}

