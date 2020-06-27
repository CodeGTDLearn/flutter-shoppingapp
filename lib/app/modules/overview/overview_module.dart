// extends from MainModule
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/app/modules/cart/service/cart_service.dart';
import 'package:shopingapp/app/modules/cart/service/i_cart_service.dart';
import 'package:shopingapp/app/modules/managed_products/services/i_managed_products_service.dart';
import 'package:shopingapp/app/modules/managed_products/services/managed_products_service.dart';
import 'package:shopingapp/app/modules/orders/repo/i_orders_repo.dart';
import 'package:shopingapp/app/modules/orders/repo/orders_firebase_repo.dart';
import 'package:shopingapp/app/modules/orders/service/i_orders_service.dart';
import 'package:shopingapp/app/modules/orders/service/orders_service.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';

import '../../config/app_routes.dart';
import '../cart/cart_controller.dart';
import '../cart/repo/cart_firebase_repo.dart';
import '../cart/repo/i_cart_repo.dart';
import '../managed_products/managed_products_controller.dart';
import 'components/overview_item/overview_item_module.dart';
import 'components/overview_item/overview_item_service.dart';
import 'components/popup_appbar_enum.dart';
import 'overview_controller.dart';
import 'pages/overview_page.dart';
import 'repo/i_overview_repo.dart';
import 'repo/overview_firebase_repo.dart';
import 'service/overview_service.dart';

class OverviewModule extends ChildModule {
  @override
  List<Bind> get binds => [
        //REPOS
        Bind<ICartRepo>((i) => CartFirebaseRepo()),
        Bind<IOrdersRepo>((i) => OrdersFirebaseRepo()),
        Bind<IOverviewRepo>((i) => OverviewFirebaseRepo()),

        //SERVICES
        Bind<ICartService>((i) => CartService()),
        Bind<IOrdersService>((i) => OrdersService()),
        Bind<IOverviewService>((i) => OverviewService()),
        Bind<IManagedProductsService>((i) => ManagedProductsService()),

        //CONTROLLERS
        Bind((i) => CartController()),
        Bind((i) => OverviewController(), singleton: false),
        Bind((i) => ManagedProductsController(), singleton: false),

        //COMPONENTS
        Bind((i) => OverviewItemService(), singleton: false),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute,
            child: (_, args) => OverviewPage(PopupEnum.All)),
        Router(OVERVIEW_ALL_ROUTE,
            child: (_, args) => OverviewPage(PopupEnum.All)),
        Router(OVERVIEW_FAV_ROUTE,
            child: (_, args) => OverviewPage(PopupEnum.Favorites)),
        Router(OVERVIEW_DEAIL_ROUTE, module: OverviewItemModule()),
      ];

  static Inject get to => Inject<OverviewModule>.of();
}
