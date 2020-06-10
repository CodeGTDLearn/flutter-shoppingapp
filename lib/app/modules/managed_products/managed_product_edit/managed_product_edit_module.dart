// extends from MainModule
import 'package:flutter_modular/flutter_modular.dart';

import 'managed_product_edit_page.dart';

class ManagedProductEditModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router('/:id',
            child: (_, args) => ManagedProductEditPage(args.params['id'])),
      ];

  static Inject get to => Inject<ManagedProductEditModule>.of();
}
