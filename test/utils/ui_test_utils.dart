import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';

import '../config/tests_properties.dart';
import 'finder_utils.dart';
import 'tests_utils.dart';

class UiTestUtils {
  final _finder = Get.put(FinderUtils());
  final _testUtils = Get.put(TestsUtils());

  Future<void> navigateBetweenViews(
    WidgetTester tester, {
    required int interval,
    required Type from,
    required Type to,
    required Type trigger,
  }) async {
    expect(_finder.type(from), findsOneWidget);
    await tester.tap(_finder.type(trigger));
    await tester.pump();
    await tester.pumpAndSettle(_testUtils.delay(interval));
    expect(_finder.type(to), findsOneWidget);
  }

  Future<void> tapButton_CheckResult(
    WidgetTester tester, {
    required int interval,
    required String triggerKey,
    required Type resultWidget,
  }) async {
    await tester.tap(_finder.key(triggerKey));
    await tester.pump();
    await tester.pump(_testUtils.delay(interval));
    await tester.pumpAndSettle();
    expect(_finder.type(resultWidget), findsWidgets);
  }

  Future<void> openDrawer_SelectAnOption(
    WidgetTester tester, {
    required int interval,
    required String optionKey,
    required GlobalKey<ScaffoldState> scaffoldGlobalKey,
  }) async {
    await tester.pumpAndSettle();
    scaffoldGlobalKey.currentState!.openDrawer();
    await tester.pumpAndSettle(Duration(milliseconds: interval * 1000 + EXTRA_DELAY));
    await tester.tap(_finder.key(optionKey));
    await tester.pumpAndSettle();
    await tester.pump(Duration(milliseconds: interval * 1000 + EXTRA_DELAY));
  }

  void check_widgetQuantityInAView({
    required Type widgetView,
    required Type widgetType,
    required int widgetQtde,
  }) {
    expect(_finder.type(widgetView), findsOneWidget);
    expect(
      _finder.type(widgetType),
      widgetQtde == 0 ? findsNothing : findsNWidgets(widgetQtde),
    );
  }

  Future<void> sendAppToBackground({required int interval}) async {
    await Future.delayed(Duration(seconds: interval), () {
      print('Application Closed.');
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  Future<void> testInitialization(
    WidgetTester tester, {
    required bool isWidgetTest,
    required Widget appDriver,
    required bool applyDelay,
  }) async {
    isWidgetTest ? await tester.pumpWidget(appDriver) : runApp(appDriver);
    if (applyDelay) await tester.pumpAndSettle(_testUtils.delay(DELAY));
  }

  Future<void> checkDarkModeTheme(
    WidgetTester tester, {
    required keyElementToCheckDarkmodeIn,
    required keyDarkmodeSwitcher,
    required BrightnessOption finalBrightnessOption,
  }) async {
    var finalStatus = finalBrightnessOption == BrightnessOption.dark
        ? Brightness.dark
        : Brightness.light;

    var initialStatus = finalBrightnessOption == BrightnessOption.dark
        ? Brightness.light
        : Brightness.dark;

    expect(
      Theme.of(tester.element(_finder.key(keyElementToCheckDarkmodeIn))).brightness,
      equals(initialStatus),
    );

    await tester.tap(_finder.key(keyDarkmodeSwitcher));
    await tester.pump();
    await tester.pumpAndSettle(_testUtils.delay(DELAY));

    expect(
      Theme.of(tester.element(_finder.key(keyElementToCheckDarkmodeIn))).brightness,
      equals(finalStatus),
    );
  }

  getWidgetProperties<T>(WidgetTester tester, {required String key}) {
    // var widgetKey = _finder.key(key);
    var retWidget;
    try {
      retWidget = (tester.widget(_finder.key(key)) as T);
    } catch (e) {
      print(e); // Catches all types of `Exception` and `Error`.
    }

    return retWidget;
  }

  /// HOW TO USE THIS METHOD
  /// uiTestUtils.scanPropertiesInSequentialWidgets<IconButton>(
  /// tester,
  /// rootKey: fav_button_key,
  /// );
  scanPropertiesInSequentialWidgets<T>(WidgetTester tester, {required String rootKey}) {
    var properties;
    var counter = 0;
    var result = '';

    do {
      properties = getWidgetProperties<IconButton>(
        tester,
        key: '$rootKey$counter',
      );

      if (properties != null) {
        result += "\n\n$counter) key: $properties";
        result = result.replaceFirstMapped('${T.toString()}-[<\'', (match) => '');
        result = result.replaceFirstMapped('\'>](', (match) => '\n        ');
        result = result.replaceAll(',', '\n       ');
        counter++;
      }
    } while (properties != null);

    print('The follow Widget were found in the View:$result)}');
  }

// UI-TEST-DIMENSIONS CONSIDERATIONS
//
// * EXPLANATIONS:
//   - FLUTTER:
//     + Uses "Logical Pixels" (not physical pixels)
//       -> LOGICAL PIXEL = 38 Pixel/centimeter
//       -> Flutter USES "LOGICAL PIXEL" in "ALL DEVICES/SCREENS"
//          => LOGICAL PIXEL allow find the same dimensions ALL SCREEN SIZES
//       -> Flutter "DOES NOT USES" physical pixels
//
//   - DevicePixelRatio:
//     + given in "Device Specs"
//
// * FORMULAS:
//   - DevicePixelRatio:
//     + Physical Pixels / Logical Pixels
//   - Find the Logical Pixels (FLUTTER):
//     + Physical Pixels (Size)  / DevicePixelRatio
  double deviceWidth(WidgetTester tester) =>
      tester.binding.window.physicalSize.width / tester.binding.window.devicePixelRatio;

  double deviceHeight(WidgetTester tester) =>
      tester.binding.window.physicalSize.height / tester.binding.window.devicePixelRatio;

  void resetTestDeviceScreen(tester) {
    // resets the screen to its original size after the test end
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  }

  Future<void> setTestDevicePhysicalSize(
    WidgetTester tester, {
    required double dx,
    required double dy,
  }) async {
    // define the screen-size for this test
    var _screenSizeDefinition = Size(dx, dy);
    await tester.binding.setSurfaceSize(_screenSizeDefinition);
    tester.binding.window.physicalSizeTestValue = _screenSizeDefinition;
    tester.binding.window.devicePixelRatioTestValue = 1.0;
  }
}

enum BrightnessOption {
  dark,
  light,
}