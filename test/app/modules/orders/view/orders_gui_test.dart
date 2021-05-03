import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../test_utils/test_utils.dart';
import '../orders_test_config.dart';
import 'orders_functional_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Orders|Gui-Tests: ', guiTests);
}

void guiTests() {
  TestUtils _seek;
  var ordersViewTests = Get.put(OrdersViewTests());
  var testConfig = Get.put(OrdersTestConfig());

  setUp(() => _seek = Get.put(TestUtils()));

  tearDown(Get.reset);

  testWidgets('${testConfig.TitleTest_TestPageBackButton}', (tester) async {
    app.main();
    await ordersViewTests.openDrawwerAndClickOrdersDrawerOption(tester, _seek);
    await ordersViewTests.TestingPageBackButton(_seek, tester);
  });
}
