// extends from MainModule
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/app/modules/cart/cart_page.dart';
import 'package:shopingapp/app/modules/orders/orders_controller.dart';
import 'package:shopingapp/app/modules/orders/orders_repo.dart';

import 'cart_controller.dart';
import 'cart_repo.dart';

class CartModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind<CartRepo>((i) => CartRepo()),
        Bind<OrdersRepo>((i) => OrdersRepo()),
        Bind<OrdersController>((i) => OrdersController()),

        //CONTROLLER (BOA PRATICA - NOVA INSTANCIA A CADA ACESSO)
        Bind<CartController>((i) => CartController(), singleton: false),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => CartPage()),
      ];

  static Inject get to => Inject<CartModule>.of();
}
