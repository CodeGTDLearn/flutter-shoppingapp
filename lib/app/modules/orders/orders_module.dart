// extends from MainModule
import 'package:flutter_modular/flutter_modular.dart';

import 'components/order_collapsable_tile_store.dart';
import 'orders_controller.dart';
import 'orders_page.dart';
import 'orders_repo.dart';

class OrdersModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind<OrdersRepo>((i) => OrdersRepo()),
        Bind<OrderCollapsableTileStore>((i) => OrderCollapsableTileStore(),
            singleton: false),

        //CONTROLLER (BOA PRATICA - NOVA INSTANCIA A CADA ACESSO)
        Bind<OrdersController>((i) => OrdersController(), singleton: false),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => OrdersPage()),
      ];

  static Inject get to => Inject<OrdersModule>.of();
}
