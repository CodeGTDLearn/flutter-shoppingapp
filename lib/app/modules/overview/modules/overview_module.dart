// extends from MainModule
import 'package:flutter_modular/flutter_modular.dart';

import '../../../config/app_routes.dart';
import '../../cart/cart_controller.dart';
import '../../cart/repo/cart_firebase_repo.dart';
import '../../cart/repo/i_cart_repo.dart';
import '../../managed_products/managed_products_controller.dart';
import '../../orders/orders_controller.dart';
import '../../orders/repo/i_orders_repo.dart';
import '../../orders/repo/orders_firebase_repo.dart';
import '../controllers/overview_controller.dart';
import '../controllers/overview_item_controller.dart';
import '../pages/overview_all_page.dart';
import '../pages/overview_fav_page.dart';
import '../repo/i_overview_firebase_repo.dart';
import '../repo/overview_firebase_repo.dart';
import 'overview_item_module.dart';

class OverviewModule extends ChildModule {
  @override
  List<Bind> get binds => [
        //CONTROLLER (BOA PRATICA - NOVA INSTANCIA A CADA ACESSO)

        Bind((i) => OverviewController(), singleton: false),
        Bind((i) => OverviewItemController(), singleton: false),

        Bind((i) => CartController(), singleton: false),
        Bind((i) => OrdersController(), singleton: false),
        Bind((i) => ManagedProductsController(), singleton: false),

        Bind<ICartRepo>((i) => CartFirebaseRepo()),
        Bind<IOrdersRepo>((i) => OrdersFirebaseRepo()),
        Bind<IOverviewRepo>((i) => OverviewFirebaseRepo()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => OverviewAllPage()),
        Router(ITEMSOVER_FAV_ROUTE, child: (_, args) => OverviewFavPage()),
        Router(ITEMDETAILS_ROUTE, module: OverviewItemModule()),
      ];

  static Inject get to => Inject<OverviewModule>.of();
}
