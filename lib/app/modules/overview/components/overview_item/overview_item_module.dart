// extends from MainModule
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/app/modules/cart/service/cart_service.dart';
import 'package:shopingapp/app/modules/cart/service/i_cart_service.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/repo/overview_firebase_repo.dart';

import '../../pages/overview_item_details_page.dart';
import 'overview_item_service.dart';

class OverviewItemModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => OverviewItemService(), singleton: false),
        Bind<ICartService>((i) => CartService(), singleton: false),
        Bind<IOverviewRepo>((i) => OverviewFirebaseRepo(), singleton: false),
      ];

  @override
  List<Router> get routers => [
        Router('/:id',
            child: (_, args) => OverviewItemDetailsPage(args.params['id'])),
      ];

  static Inject get to => Inject<OverviewItemModule>.of();
}
