import 'package:mobx/mobx.dart';

part 'items_overview_serv_store.g.dart';

class ItemsOverviewServStore = IItemsOverviewServStore
    with _$ItemsOverviewServStore;

abstract class IItemsOverviewServStore with Store {
  @observable
  int filterSelected;

  @action
  void selectFilter(int popupSelection) {
    this.filterSelected = popupSelection == 0 ? 0 : 1;
  }
}
