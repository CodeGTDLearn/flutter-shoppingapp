// extends from MainModule
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/app/modules/orders/service/i_orders_service.dart';

import 'components/order_collapsable_tile_store.dart';
import 'orders_controller.dart';
import 'orders_page.dart';
import 'repo/i_orders_repo.dart';
import 'repo/orders_firebase_repo.dart';
import 'service/orders_service.dart';

class OrdersModule extends ChildModule {
  @override
  List<Bind> get binds => [
        //REPOS
        Bind<IOrdersRepo>((i) => OrdersFirebaseRepo()),

        //SERVICES
        Bind<IOrdersService>((i) => OrdersService()),

        //CONTROLLER: BOA PRATICA - NOVA INSTANCIA A CADA ACESSO
        Bind((i) => OrdersController()),

        //COMPONENTS
        Bind<OrderCollapsableTileStore>((i) => OrderCollapsableTileStore(),
            singleton: false),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => OrdersPage()),
      ];

  static Inject get to => Inject<OrdersModule>.of();
}
