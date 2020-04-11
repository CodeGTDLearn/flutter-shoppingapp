// extends from MainModule
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/config/specs.dart';
import 'package:shopingapp/entities_models/product.dart';
import 'package:shopingapp/repositories/cart_repo.dart';
import 'package:shopingapp/repositories/i_cart_repo.dart';
import 'package:shopingapp/repositories/i_orders_repo.dart';
import 'package:shopingapp/repositories/i_products_repo.dart';
import 'package:shopingapp/repositories/orders_repo.dart';
import 'package:shopingapp/repositories/products_repo.dart';
import 'package:shopingapp/service_stores/ItemsOverviewGridProductItemStore.dart';
import 'package:shopingapp/service_stores/ItemsOverviewGridProductsStore.dart';
import 'package:shopingapp/service_stores/CartStore.dart';
import 'package:shopingapp/service_stores/OrdersStore.dart';
import 'package:shopingapp/views/cart_view.dart';

import 'package:shopingapp/views/item_detail_view.dart';
import 'package:shopingapp/views/items_overview_fav_view.dart';
import 'package:shopingapp/views/items_overview_view.dart';
import 'package:shopingapp/views/order_view.dart';

import '../app_driver.dart';
import 'appProperties.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind<IItemsOverviewGridProductsStore>(
            (i) => ItemsOverviewGridProductsStore()),
        Bind<IItemsOverviewGridProductItemStore>(
            (i) => ItemsOverviewGridProductItemStore(),
            singleton: false),
        Bind<IProductsRepo>((i) => ProductsRepo()),
        Bind<ICartRepo>((i) => CartRepo()),
        Bind<ICartStore>((i) => CartStore()),
        Bind<IOrdersRepo>((i) => OrdersRepo()),
        Bind<IOrdersStore>((i) => OrdersStore()),
        Bind((i) => Product),
      ];

  @override
  List<Router> get routers => [
        Router(ROUTE_ITEM_OVERV_VIEW, child: (_, args) => ItemsOverviewView()),
        Router(ROUTE_ITEM_OVERV_FAV_VIEW,
            child: (_, args) => ItemsOverviewFavView(),
            transition: TransitionType.noTransition),
        Router(ROUTE_CART, child: (_, args) => CartView()),
        Router(ROUTE_ORDERS, child: (_, args) => OrderView()),
        Router(ROUTE_ITEM_DETAIL + ':id',
            child: (_, args) => ItemDetailView(args.params['id'])),
      ];

  @override
  Widget get bootstrap => AppDriver();
}
