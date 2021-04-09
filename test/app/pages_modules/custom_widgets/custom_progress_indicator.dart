import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/core/properties/theme/dark_theme_controller.dart';
import 'package:shopingapp/app/core/texts_icons_provider/app_messages.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/overview.dart';
import 'package:shopingapp/app/pages_modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/pages_modules/custom_widgets/core/keys/custom_circ_progr_indicator_keys.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/pages_modules/overview/service/overview_service.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../test_utils/custom_test_methods.dart';
import '../../../test_utils/mocked_datasource/products_mocked_datasource.dart';
import '../../../test_utils/test_utils.dart';
import '../overview/repo/overview_repo_mocks.dart';

class CustomProgressIndicatorTest {
  static void functional() {
    TestUtils seek;

    final binding = BindingsBuilder(() {
      Get.lazyPut<DarkThemeController>(() => DarkThemeController());

      Get.lazyPut<IOverviewRepo>(() => OverviewMockRepo());
      // Get.lazyPut<IOverviewRepo>(() => OverviewInjectMockRepo());

      Get.lazyPut<IOverviewService>(
          () => OverviewService(repo: Get.find<IOverviewRepo>()));

      Get.lazyPut<OverviewController>(
          () => OverviewController(service: Get.find<IOverviewService>()));
    });

    setUp(() {

      // expect(Get.isPrepared<OverviewInjectMockRepo>(), isFalse);
      expect(Get.isPrepared<IOverviewRepo>(), isFalse);
      expect(Get.isPrepared<IOverviewService>(), isFalse);
      expect(Get.isPrepared<OverviewController>(), isFalse);
      binding.builder();
      // expect(Get.isPrepared<OverviewInjectMockRepo>(), isTrue);
      expect(Get.isPrepared<IOverviewRepo>(), isTrue);
      expect(Get.isPrepared<IOverviewService>(), isTrue);
      expect(Get.isPrepared<OverviewController>(), isTrue);

      HttpOverrides.global = null;
      seek = TestUtils();
    });

    tearDown(() {
      seek = null;
      CustomTestMethods.globalTearDown();
    });

    List<Product> _products() {
      return Get.find<IOverviewService>().getLocalDataAllProducts();
    }

    void _isInstancesRegistred() {
      expect(Get.isRegistered<OverviewInjectMockRepo>(), isTrue);
      expect(Get.isRegistered<IOverviewRepo>(), isTrue);
      expect(Get.isRegistered<IOverviewService>(), isTrue);
      expect(Get.isRegistered<OverviewController>(), isTrue);
    }

    testWidgets('Checking CustomProgrIndicator with DataDB', (tester) async {
      await tester.pumpWidget(AppDriver());
      _isInstancesRegistred();

      expect(seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);
      expect(seek.text(NO_PRODUCTS_FOUND_IN_YET), findsNothing);

      await tester.pump();
      await tester.pump(seek.delay(3));
      expect(seek.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
      expect(seek.text(_products()[0].title.toString()), findsOneWidget);
    });

    testWidgets('Checking CustomProgrIndicator EmptyDB', (tester) async {
      // @formatter:off
      // when(_injectMockService.getProducts())
      //     .thenAnswer((_) async => Future
      //     .value(ProductsMockedDatasource()
      //     .productsEmpty()));
      //
      // _injectMockService.getProducts().then((value) {
      //   expect(value, List.empty());
      // });
      // @formatter:on

      await tester.pumpWidget(AppDriver());
      _isInstancesRegistred();

      expect(seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);
      expect(seek.text(NO_PRODUCTS_FOUND_IN_YET), findsNothing);

      await tester.pump();
      await tester.pump(seek.delay(3));
      expect(seek.text(OVERVIEW_TITLE_PAGE_ALL), findsOneWidget);
      expect(seek.text(_products()[0].title.toString()), findsNothing);
    });
  }
}
