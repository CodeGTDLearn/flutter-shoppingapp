// extends from MainModule
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/app/config/app_routes.dart';

import 'managed_product_edit/managed_product_edit_module.dart';
import 'managed_product_edit/managed_product_edit_page.dart';
import 'managed_products_controller.dart';
import 'managed_products_page.dart';

class ManagedProductsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        //CONTROLLER (BOA PRATICA - NOVA INSTANCIA A CADA ACESSO)
        Bind<ManagedProductsController>((i) => ManagedProductsController()),
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
