import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/app/modules/overview/product_repo.dart';

import '../overview/product.dart';

part 'managed_products_controller.g.dart';

class ManagedProductsController = ManagedProductsControllerBase
    with _$ManagedProductsController;

abstract class ManagedProductsControllerBase with Store {
  final _repo = Modular.get<ProductsRepo>();

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
    bool ret = _repo.add(product);
    products = getAll();
    return ret;
  }

  @action
  bool update(Product product) {
    bool ret = _repo.update(product);
    products = getAll();
    return ret;
  }

  @action
  void delete(String id) {
    _repo.delete(id);
    products = getAll();
  }
}
