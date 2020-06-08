import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../entities/product.dart';
import '../repositories/productsRepoInt.dart';

part 'managedProductsStore.g.dart';

class ManagedProductsStore = ManagedProductsStoreInt
    with _$ManagedProductsStore;

abstract class ManagedProductsStoreInt with Store {
  final _repo = Modular.get<ProductsRepoInt>();

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
