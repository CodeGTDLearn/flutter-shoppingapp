import 'package:flutter_test/flutter_test.dart';

import '../../app/modules/overview/overview_controller_test.dart';
import '../../app/modules/overview/repo/overview_repo_test.dart';
import '../../app/modules/overview/service/overview_service_test.dart';
import '../../app/modules/overview/view/overview_view_test.dart';
import '../tests_properties.dart';
import '../titles/overview_tests_titles.dart';

class OverviewTestGroups {
  void groups({required bool skipGroup}) {
    group(
      OverviewTestsTitles().REPO_TITLE,
      OverviewRepoTests.unit,
      skip: skipGroup, //'skip-group' overrides the internal 'skip-methods'
    );

    group(
      OverviewTestsTitles().SERVICE_TITLE,
      OverviewServiceTests.unit,
      skip: skipGroup,
    );

    group(
      OverviewTestsTitles().CONTROLLER_TITLE,
      OverviewControllerTests.integration,
      skip: skipGroup,
    );

    group(
      OverviewTestsTitles().VIEW_TITLE,
      OverviewViewTest(testType: WIDGET_TEST).functional,
      skip: skipGroup,
    );
  }
}
