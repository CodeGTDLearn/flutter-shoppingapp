import 'package:flutter/material.dart';

import '../../../config/titles_icons/views/orders.dart';

class OrderCollapseTileStore{
//  @observable
  Icon collapsingTileIcon;

//  @observable
  bool isTileCollapsed = false;

//  @action
  void toggleCollapseTile() {
    collapsingTileIcon =
        isTileCollapsed == false ? ORDERS_ICO_UNCOLLAPSE : ORDERS_ICO_COLLAPSE;
    isTileCollapsed = !isTileCollapsed;
  }
}
