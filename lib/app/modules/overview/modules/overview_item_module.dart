// extends from MainModule
import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/overview_item_controller.dart';
import '../pages/overview_item_page.dart';

class OverviewItemModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => OverviewItemController(), singleton: false),
      ];

  @override
  List<Router> get routers => [
        Router('/:id', child: (_, args) => OverviewItemPage(args.params['id'])),
      ];

  static Inject get to => Inject<OverviewItemModule>.of();
}
