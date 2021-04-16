import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/theme/dark_theme_controller.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/modules/components/core/keys/progres_indicator_keys.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/service/overview_service.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../test_utils/test_utils.dart';
import '../overview/repo/overview_repo_mocks.dart';
import 'components_test_config.dart';

class ProgresIndicatorTest {
  static void functional() {
    TestUtils seek;

    void bindigBuilderDependenciesManagement(IOverviewRepo repo) {
      expect(Get.isPrepared<DarkThemeController>(), isFalse);
      expect(Get.isPrepared<IOverviewRepo>(), isFalse);
      expect(Get.isPrepared<IOverviewService>(), isFalse);
      expect(Get.isPrepared<OverviewController>(), isFalse);

      var binding = BindingsBuilder<dynamic>(() {
        Get.lazyPut<DarkThemeController>(() => DarkThemeController());
        Get.lazyPut<IOverviewRepo>(() => repo);
        Get.lazyPut<IOverviewService>(
            () => OverviewService(repo: Get.find<IOverviewRepo>()));
        Get.lazyPut<OverviewController>(
            () => OverviewController(service: Get.find<IOverviewService>()));
      });

      binding.builder();

      expect(Get.isPrepared<DarkThemeController>(), isTrue);
      expect(Get.isPrepared<IOverviewRepo>(), isTrue);
      expect(Get.isPrepared<IOverviewService>(), isTrue);
      expect(Get.isPrepared<OverviewController>(), isTrue);
    }

    setUp(() {
      seek = TestUtils();
    });

    tearDown(() {
      seek = null;
      TestMethods.globalTearDown();
    });

    List<Product> _products() {
      return Get.find<IOverviewService>().getLocalDataAllProducts();
    }

    void _isInstancesRegistred() {
      expect(Get.isRegistered<DarkThemeController>(), isTrue);
      expect(Get.isRegistered<IOverviewRepo>(), isTrue);
      expect(Get.isRegistered<IOverviewService>(), isTrue);
      expect(Get.isRegistered<OverviewController>(), isTrue);
    }

    testWidgets('Checking CustomProgrIndicator', (tester) async {
      bindigBuilderDependenciesManagement(ComponentsTestConfig().testsRepo);

      await tester.pumpWidget(AppDriver());
      _isInstancesRegistred();

      expect(seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);

      await tester.pump();
      await tester.pump(seek.delay(3));

      expect(seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsNothing);
      expect(seek.text(NO_PRODUCTS_FOUND_IN_YET), findsNothing);

      expect(seek.text(_products()[0].title.toString()), findsOneWidget);
      expect(seek.text(_products()[1].title.toString()), findsOneWidget);
    });

    testWidgets('Checking CustomProgrIndicator EmptyDB', (tester) async {
      bindigBuilderDependenciesManagement(OverviewMockRepoEmptyDb());

      await tester.pumpWidget(AppDriver());
      _isInstancesRegistred();

      expect(seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);
      expect(seek.type(CircularProgressIndicator), findsOneWidget);
      expect(seek.text(NO_PRODUCTS_FOUND_IN_YET), findsNothing);

      await tester.pump();
      await tester.pump(seek.delay(3));

      expect(seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);
      expect(seek.type(CircularProgressIndicator), findsNothing);
      expect(seek.text(NO_PRODUCTS_FOUND_IN_YET), findsOneWidget);
    });
  }
}
