import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/config/titlesIcons.dart';

part 'OrderCollapsableTileStore.g.dart';

class OrderCollapsableTileStore = IOrderCollapsableTileStore with _$OrderCollapsableTileStore;

abstract class IOrderCollapsableTileStore with Store {
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
