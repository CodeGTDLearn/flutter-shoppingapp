import 'package:flutter_driver/flutter_driver.dart';
import 'package:shopingapp/app/pages_modules/overview/core/messages_snackbars_provided.dart';
import 'package:shopingapp/app/pages_modules/overview/core/overview_widget_keys.dart';
import 'package:test/test.dart';

class OverviewPageModule {
  static void integrationTest() {
    FlutterDriver driver;
    var delay = 2;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) driver.close();
    });

    SerializableFinder _find(String key) {
      return find.byValueKey(key);
    }

    var key1 = _find(OV001);
    var key8 = _find(FB001);

    test('OVERVIEW_GRID_ITEM: Triggering favorite button', () async {
      await driver.clearTimeline();

      await driver
          .tap(key1)
          .then((value) => Future.delayed(Duration(seconds: delay)))
          .then((value) => driver.waitFor(key8));

      await driver.waitUntilNoTransientCallbacks();

      assert(key8 != null);
      expect(await driver.getText(key8), TOGGLE_STATUS_SUCESS);
    });
  }
}
