// extends from MainModule
import 'package:flutter_modular/flutter_modular.dart';

import '../../config/app_routes.dart';
import '../overview/repo/i_overview_repo.dart';
import '../overview/repo/overview_firebase_repo.dart';
import 'managed_product_edit/managed_product_edit_module.dart';
import 'managed_product_edit/managed_product_edit_page.dart';
import 'managed_products_page.dart';
import 'services/i_managed_products_service.dart';
import 'services/managed_products_service.dart';

class ManagedProductsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        //CONTROLLERS
        //Bind((i) => ManagedProductsController()),

        //REPOS
        Bind<IOverviewRepo>((i) => OverviewFirebaseRepo()),

        //SERVICES
        Bind<IManagedProductsService>((i) => ManagedProductsService()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => ManagedProductsPage()),
        Router(MANAGPRODUCT_ADD_ROUTE,
            child: (_, args) => ManagedProductEditPage()),
        Router(MANAGPRODUCT_EDIT_ROUTE, module: ManagedProductEditModule()),
      ];

  static Inject get to => Inject<ManagedProductsModule>.of();
}
