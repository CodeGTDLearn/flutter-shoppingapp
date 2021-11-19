import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopingapp/app/core/keys/components/custom_drawer_keys.dart';
import 'package:shopingapp/app/core/keys/overview_keys.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_view.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../config/tests_properties.dart';
import '../../../utils/finder_utils.dart';
import '../../../utils/tests_utils.dart';
import '../../../utils/ui_test_utils.dart';

class CustomDrawerTests {
  final bool isWidgetTest;
  final FinderUtils finder;
  final UiTestUtils uiTestUtils;
  final TestsUtils testUtils;

  CustomDrawerTests({
    required this.finder,
    required this.uiTestUtils,
    required this.isWidgetTest,
    required this.testUtils,
  });

  Future<void> tap_two_different_options_in_drawer(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );
    var scaffoldState = DRAWWER_SCAFFOLD_GLOBALKEY.currentState!;

    for (var i = 0; i <= 1; i++) {
      scaffoldState.openDrawer();
      await tester.pumpAndSettle(testUtils.delay(DELAY));
      expect(scaffoldState.isDrawerOpen, isTrue);

      if (i == 0) await tester.tap(finder.key(DRAWER_OVERVIEW_OPTION_KEY));
      if (i == 1) await tester.tap(finder.key(DRAWER_INVENTORY_OPTION_KEY));
      await tester.pumpAndSettle(testUtils.delay(DELAY));

      expect(finder.type(i == 0 ? OverviewView : InventoryView), findsOneWidget);
      expect(scaffoldState.isDrawerOpen, isFalse);
    }

    await uiTestUtils.navigateBetweenViews(
      tester,
      from: InventoryView,
      to: OverviewView,
      trigger: BackButton,
      interval: DELAY,
    );
  }

  Future<void> close_drawer_tap_outside(WidgetTester tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    var scaffoldState = DRAWWER_SCAFFOLD_GLOBALKEY.currentState!;
    expect(scaffoldState.isDrawerOpen, isFalse);

    scaffoldState.openDrawer();
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(scaffoldState.isDrawerOpen, isTrue);

    await tester.tapAt(Offset(
      uiTestUtils.deviceWidth(tester) * 0.97,
      uiTestUtils.deviceHeight(tester) * 0.97,
    ));
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(scaffoldState.isDrawerOpen, isFalse);
  }

  Future<void> tap_drawer_darkmode_option(WidgetTester tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: true,
    );

    var scaffoldState = DRAWWER_SCAFFOLD_GLOBALKEY.currentState!;

    scaffoldState.openDrawer();
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(scaffoldState.isDrawerOpen, isTrue);

    await uiTestUtils.checkDarkModeTheme(tester,
        keyDarkmodeSwitcher: DRAWER_DARK_MODE_OPTION_KEY,
        keyElementToCheckDarkmodeIn: OVERVIEW_PAGE_TITLE_APPBAR_KEY,
        finalBrightnessOption: BrightnessOption.dark);

    await tester.tapAt(Offset(
      uiTestUtils.deviceWidth(tester) * 0.97,
      uiTestUtils.deviceHeight(tester) * 0.97,
    ));
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(scaffoldState.isDrawerOpen, isFalse);
  }
}