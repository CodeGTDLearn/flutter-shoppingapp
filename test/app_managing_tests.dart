import 'package:test/test.dart';

import 'app/pages_modules/overview/controller/overview_controller_test.dart';
import 'app/pages_modules/overview/overview_page_test.dart';
import 'app/pages_modules/overview/repo/overview_repo_test.dart';
import 'app/pages_modules/overview/service/overview_service_test.dart';

void main() {
  group('Overview Page - Repo: ', OverviewRepoTest.MockTests);
  group('Overview Page - Service: ', OverviewServiceTest.IntegrationTests);
  group(
      'Overview Page - Controller: ', OverviewControllerTest.IntegrationTests);
  group(
      'Overview Page - UI(Widget Tests): ', OverviewPageTest
      .WidgetIntegrationTests);
}
