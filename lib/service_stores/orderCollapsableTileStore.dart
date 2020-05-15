import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../config/titlesIconsMessages/views/ordersView.dart';

part 'orderCollapsableTileStore.g.dart';

class OrderCollapsableTileStore = OrderCollapsableTileStoreInt with _$OrderCollapsableTileStore;

abstract class OrderCollapsableTileStoreInt with Store {
  @observable
  Icon collapsingTileIcon;

  @observable
  bool isTileCollapsed = false;

  @action
  void toggleCollapseTile() {
    collapsingTileIcon = isTileCollapsed == false ? ORD_ICO_EXPLES : ORD_ICO_EXPMOR;
    isTileCollapsed = !isTileCollapsed;
  }
}
