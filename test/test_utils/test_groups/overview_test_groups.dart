import 'package:test/test.dart';

import '../../app/modules/overview/overview_controller_test.dart';
import '../../app/modules/overview/pages/overview_item_details_page_test.dart';
import '../../app/modules/overview/pages/overview_page_test.dart';
import '../../app/modules/overview/repo/overview_repo_test.dart';
import '../../app/modules/overview/service/overview_service_test.dart';
import 'config.dart';

class OverviewTestGroups {
  static void groups() {
    group("$OVERVIEW$OVERVIEW_REPO", OverviewRepoTest.unit);

    group("$OVERVIEW$OVERVIEW_SERVICE", OverviewServiceTest.unit);

    group("$OVERVIEW$OVERVIEW_CONTROLLER", OverviewControllerTest.integration);

    group("$OVERVIEW$OVERVIEW_VIEW", OverviewPageTest.functional);

    group("$OVERVIEW$OVERVIEW_DETAIL_VIEW", OverviewDetailsPageTest.functional);
  }
}
