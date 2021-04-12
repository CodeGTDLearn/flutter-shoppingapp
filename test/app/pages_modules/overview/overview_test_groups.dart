import 'package:test/test.dart';

import 'overview_controller_test.dart';
import 'pages/overview_item_details_page_test.dart';
import 'pages/overview_page_test.dart';
import 'repo/overview_repo_test.dart';
import 'service/overview_service_test.dart';

class OverviewModuleTest {
  static void groups() {
    const OVERVIEW_MODULE_PAGE = 'Overview|';

    group(
      "$OVERVIEW_MODULE_PAGE\MockedRepo: Unit",
      OverviewRepoTest.unit,
    );

    group(
      "$OVERVIEW_MODULE_PAGE\Service|MockedRepo: Unit",
      OverviewServiceTest.unit,
    );

    group(
      "$OVERVIEW_MODULE_PAGE\Controller|Service|MockedRepo: Integr",
      OverviewControllerTest.integration,
    );

    group(
      "$OVERVIEW_MODULE_PAGE\View|Page: Functional",
      OverviewPageTest.functional,
    );

    group(
      "$OVERVIEW_MODULE_PAGE\View|Item Details Page: Functional",
      OverviewItemDetailsPageTest.functional,
    );
  }
}
