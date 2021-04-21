import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/theme/dark_theme_controller.dart';
import 'package:shopingapp/app/modules/cart/core/cart_bindings.dart';
import 'package:shopingapp/app/modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/repo/overview_repo_http.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app/modules/overview/service/overview_service.dart';

/*  todo: nosql local-dbs
    https://objectbox.io/flutter-databases-sqflite-hive-objectbox-and-moor/
    https://pub.dev/packages/idb_shim
    https://pub.dev/packages/sembast
    https://blog.codemagic.io/choosing-the-right-database-for-your-flutter-app/
 */
class OverviewTestConfig {
  BindingsBuilder<dynamic> testBinding = BindingsBuilder(() {
    Get.lazyPut<DarkThemeController>(() => DarkThemeController());

    //REPO-USED-IN-THIS-TEST-MODULE:
    // Get.lazyPut<IOverviewRepo>(() => OverviewMockRepo());
    Get.lazyPut<IOverviewRepo>(() => OverviewRepoHttp());
    Get.lazyPut<IOverviewService>(
        () => OverviewService(repo: Get.find<IOverviewRepo>()));
    Get.lazyPut<OverviewController>(
        () => OverviewController(service: Get.find<IOverviewService>()));

    CartBindings().dependencies();
  });

//TEST-GROUPS-TITLES:
  final OVERVIEW_REPO = 'Overview|Repo: Unit';
  final OVERVIEW_SERVICE = 'Overview|Service|Repo: Unit';
  final OVERVIEW_CONTROLLER = 'Overview|Controller|Service|Repo: Integr';
  final OVERVIEW_VIEW = 'Overview|View: Functional';
  final OVERVIEW_DETAIL_VIEW = 'Overview|View|Details: Functional';
}
