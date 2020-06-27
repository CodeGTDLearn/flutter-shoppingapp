// extends from MainModule
import 'package:flutter_modular/flutter_modular.dart';

import './../../modules/cart/cart_page.dart';
import 'cart_controller.dart';

class CartModule extends ChildModule {
  @override
  List<Bind> get binds => [
        //CONTROLLER (BOA PRATICA - NOVA INSTANCIA A CADA ACESSO)
        Bind((i) => CartController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => CartPage()),
      ];

  static Inject get to => Inject<CartModule>.of();
}
