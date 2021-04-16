import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';

import '../overview/repo/overview_repo_mocks.dart';

class ComponentsTestConfig {
  final IOverviewRepo _repository_to_be_used_in_all_components_modules_tests =
      OverviewMockRepo();

  final COMPONENTS_DRAWER = 'Components|Drawer: Functional';
  final COMPONENTS_PROGRESS_INDICATOR =
      'Components|ProgressIndicator: Functional';

  IOverviewRepo get testsRepo =>
      _repository_to_be_used_in_all_components_modules_tests;
}
