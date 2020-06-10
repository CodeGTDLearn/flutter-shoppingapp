// extends from MainModule
import 'package:flutter_modular/flutter_modular.dart';

import 'item_details_page.dart';

class ItemDetails extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router('/:id', child: (_, args) => ItemDetailsPage(args.params['id'])),
      ];

  static Inject get to => Inject<ItemDetails>.of();
}
