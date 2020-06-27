// extends from MainModule
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/app/modules/cart/repo/cart_firebase_repo.dart';
import 'package:shopingapp/app/modules/cart/repo/i_cart_repo.dart';
import 'package:shopingapp/app/modules/orders/repo/i_orders_repo.dart';
import 'package:shopingapp/app/modules/orders/repo/orders_firebase_repo.dart';

import './../../modules/cart/cart_page.dart';
import '../orders/service/i_orders_service.dart';
import '../orders/service/orders_service.dart';
import 'cart_controller.dart';
import 'service/cart_service.dart';
import 'service/i_cart_service.dart';

class CartModule extends ChildModule {
  @override
  List<Bind> get binds => [
        //REPOS
        Bind<ICartRepo>((i) => CartFirebaseRepo()),
        Bind<IOrdersRepo>((i) => OrdersFirebaseRepo()),

        //SERVICES
        Bind<ICartService>((i) => CartService()),
        Bind<IOrdersService>((i) => OrdersService()),

        //CONTROLLER: BOA PRATICA - NOVA INSTANCIA A CADA ACESSO
        Bind((i) => CartController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => CartPage()),
      ];

  static Inject get to => Inject<CartModule>.of();
}
