import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../overview/product.dart';
import '../overview/repo/overview_firebase_repo.dart';

part 'managed_products_controller.g.dart';

class ManagedProductsController = _ManagedProductsControllerBase
    with _$ManagedProductsController;

abstract class _ManagedProductsControllerBase with Store {
  final _repo = Modular.get<OverviewFirebaseRepo>();

  @observable
  int qtdeManagedProducts = 0;

  @observable
  List<Product> products;

  @action
  List<Product> getAll() {
    products = _repo.getAll();
    return products;
  }

  void calcQtdeManagedProducts() {
    qtdeManagedProducts = _repo.getAll().length;
  }

  Product getById(String id) {
    return _repo.getById(id);
  }

  @action
  bool add(Product product) {
    product.set_id(DateTime.now().toString());
    var ret = _repo.add(product);
    products = getAll();
    return ret;
  }

  @action
  bool update(Product product) {
    var ret = _repo.update(product);
    products = getAll();
    return ret;
  }

  @action
  void delete(String id) {
    _repo.delete(id);
    products = getAll();
  }
}
