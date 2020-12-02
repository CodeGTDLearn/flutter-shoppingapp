import 'package:test/test.dart';

import '../app/pages_modules/overview/controller/overview_controller_test.dart';
import '../app/pages_modules/overview/pages/overview_item_details_page_test.dart';
import '../app/pages_modules/overview/pages/overview_page_test.dart';
import '../app/pages_modules/overview/repo/overview_repo_test.dart';
import '../app/pages_modules/overview/service/overview_service_test.dart';

class OverviewModule{

  static void groups() {
    const OVERVIEW_MODULE_PAGE = 'Overview|';
    group(
      "$OVERVIEW_MODULE_PAGE\MockedRepo: Unit",
      OverviewRepoTest.unitTests,
    );
    group(
      "$OVERVIEW_MODULE_PAGE\Service|MockedRepo: Unit",
      OverviewServiceTest.unitTests,
    );
    group(
      "$OVERVIEW_MODULE_PAGE\Controller|Service|MockedRepo: Integr",
      OverviewControllerTest.integrationTests,
    );
    group(
      "$OVERVIEW_MODULE_PAGE\Main Page: Integr/Functional",
      OverviewPageTest.widgetTests,
    );
    group(
      "$OVERVIEW_MODULE_PAGE\Details Product Page: Integr/Functional",
      OverviewItemDetailsPageTest.widgetTests,
    );
  }
}