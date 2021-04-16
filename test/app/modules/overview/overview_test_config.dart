import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';

import 'repo/overview_repo_mocks.dart';

/* todo: nosql local-dbs
https://objectbox.io/flutter-databases-sqflite-hive-objectbox-and-moor/
https://pub.dev/packages/idb_shim
https://pub.dev/packages/sembast
https://blog.codemagic.io/choosing-the-right-database-for-your-flutter-app/
 */
class OverviewTestConfig {
//REPO-USED-IN-THIS-TEST-MODULE:
  final IOverviewRepo _repository_to_be_used_in_all_overview_modules_tests =
      OverviewMockRepo();

//   final IOverviewRepo OVERVIEW_REPO_OF_TEST = OverviewRepoHttp();
// final IOverviewRepo OVERVIEW_REPO_OF_TEST =
//     OverviewRepoRetrofit(Dio(),baseUrl: URL_FIREBASE);

//TEST-GROUPS-TITLES:
  final OVERVIEW_REPO = 'Overview|Repo: Unit';
  final OVERVIEW_SERVICE = 'Overview|Service|Repo: Unit';
  final OVERVIEW_CONTROLLER = 'Overview|Controller|Service|Repo: Integr';
  final OVERVIEW_VIEW = 'Overview|View: Functional';
  final OVERVIEW_DETAIL_VIEW = 'Overview|Details View: Functional';

  IOverviewRepo get testsRepo =>
      _repository_to_be_used_in_all_overview_modules_tests;
}
