import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/keys/global_widgets_keys.dart';
import 'package:shopingapp/app/core/keys/modules/overview_keys.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_view.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../config/app_tests_properties.dart';
import '../../../utils/finder_utils.dart';
import '../../../utils/tests_utils.dart';
import '../../../utils/ui_test_utils.dart';

class CustomDrawerTests {
  final bool isWidgetTest;
  final FinderUtils finder;
  final UiTestUtils uiTestUtils;
  final TestsUtils testUtils;
  final _keys = Get.find<OverviewKeys>();
  final _keysDrawer = Get.find<GlobalWidgetsKeys>();

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

    var scaffoldState = _keys.k_ov_scfld_glob_state();

    scaffoldState!.openDrawer();

    for (var i = 0; i <= 1; i++) {
      scaffoldState.openDrawer();
      await tester.pumpAndSettle(testUtils.delay(DELAY));
      expect(scaffoldState.isDrawerOpen, isTrue);

      if (i == 0) await tester.tap(finder.key(_keysDrawer.k_drw_overview_opt1()));
      if (i == 1) await tester.tap(finder.key(_keysDrawer.k_drw_inventory_opt4()));
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

    var scaffoldState = _keys.k_ov_scfld_glob_state();

    expect(scaffoldState!.isDrawerOpen, isFalse);

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

    var scaffoldState = _keys.k_ov_scfld_glob_state();

    // scaffoldState!.isDrawerOpen;

    scaffoldState!.openDrawer();
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(scaffoldState.isDrawerOpen, isTrue);

    await uiTestUtils.checkDarkModeTheme(tester,
        keyDarkmodeSwitcher: _keysDrawer.k_drw_darkthm_opt5(),
        keyElementToCheckDarkmodeIn: _keys.k_ov_tit_appbar,
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