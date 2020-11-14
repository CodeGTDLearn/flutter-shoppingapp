import 'package:test/test.dart';

import 'app/pages_modules/cart/repo/cart_repo_test.dart';
import 'app/pages_modules/overview/controller/overview_controller_test.dart';
import 'app/pages_modules/overview/overview_page_test.dart';
import 'app/pages_modules/overview/repo/overview_repo_test.dart';
import 'app/pages_modules/overview/service/overview_service_test.dart';

void main() {
  group('Overview Page: Repo', OverviewRepoTest.unitTests);
  group('Overview Page: Service', OverviewServiceTest.unitTests);
  group('Overview Page: Controller', OverviewControllerTest.integrationTests);
  group('Overview Page: UI(Widget Tests)', OverviewPageTest.widgetTests);

  group('Cart Page: Repo: ', CartRepoTest.unitTests);
}
