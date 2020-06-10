// extends from MainModule
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/app/config/app_routes.dart';
import 'package:shopingapp/app/modules/cart/cart_controller.dart';
import 'package:shopingapp/app/modules/cart/cart_repo.dart';
import 'package:shopingapp/app/modules/managed_products/managed_products_controller.dart';
import 'package:shopingapp/app/modules/orders/orders_controller.dart';
import 'package:shopingapp/app/modules/orders/orders_repo.dart';
import 'package:shopingapp/app/modules/overview/product_repo.dart';

import 'items_details/item_details.dart';
import 'overview_all_page.dart';
import 'overview_fav_page.dart';
import 'overview_grid_product_controller.dart';
import 'overview_grid_product_item_controller.dart';

class OverviewModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind<CartRepo>((i) => CartRepo()),
        Bind<OrdersRepo>((i) => OrdersRepo()),
        Bind<ProductsRepo>((i) => ProductsRepo()),

        Bind<CartController>((i) => CartController()),
        Bind<OrdersController>((i) => OrdersController()),
        Bind<ManagedProductsController>((i) => ManagedProductsController()),

        //CONTROLLER (BOA PRATICA - NOVA INSTANCIA A CADA ACESSO)
        Bind<OverviewGridProductItemController>(
            (i) => OverviewGridProductItemController(),
            singleton: false),
        Bind<OverviewGridProductController>(
            (i) => OverviewGridProductController(),
            singleton: false),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => OverviewAllPage()),
        Router(ITEMSOVER_FAV_ROUTE, child: (_, args) => OverviewFavPage()),
        Router(ITEMDETAILS_ROUTE, module: ItemDetails()),
      ];

  static Inject get to => Inject<OverviewModule>.of();
}
