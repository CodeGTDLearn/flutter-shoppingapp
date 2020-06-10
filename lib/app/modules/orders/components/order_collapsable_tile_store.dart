import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/app/config/titles_icons/views/orders.dart';

part 'order_collapsable_tile_store.g.dart';

class OrderCollapsableTileStore = OrderCollapsableTileStoreBase
    with _$OrderCollapsableTileStore;

abstract class OrderCollapsableTileStoreBase with Store {
  @observable
  Icon collapsingTileIcon;

  @observable
  bool isTileCollapsed = false;

  @action
  void toggleCollapseTile() {
    collapsingTileIcon =
        isTileCollapsed == false ? ORDERS_ICO_UNCOLLAPSE : ORDERS_ICO_COLLAPSE;
    isTileCollapsed = !isTileCollapsed;
  }
}
