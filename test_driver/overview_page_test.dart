import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('CI-CD-01: Integration Test - Overview Page', () {
    FlutterDriver driver;
    var delay = 2;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() {
      if (driver != null) driver.close();
    });

    // SerializableFinder _find(String key) {
    //   return find.byValueKey(key);
    // }

    var key1 = find.byValueKey("ov01-0");
    var key8 = find.byValueKey("fb01");

    test('OVERVIEW_GRID_ITEM: Triggering favorite button', () async {
      await driver.clearTimeline();

      await driver
          .tap(key1)
          .then((value) => Future.delayed(Duration(seconds: delay)))
          .then((value) => driver.waitFor(key8));

      await driver.waitUntilNoTransientCallbacks();

      assert(key8 != null);
      // expect(await driver.getText(key8), TOGGLE_STATUS_SUCESS);
    });
  });
}
