import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../overview/product.dart';
import 'services/i_managed_products_service.dart';

part 'managed_products_controller.g.dart';

class ManagedProductsController = _ManagedProductsControllerBase
    with _$ManagedProductsController;

abstract class _ManagedProductsControllerBase with Store {
  final _service = Modular.get<IManagedProductsService>();

  @observable
  List<Product> managedProducts;

  @action
  void getAll() {
    managedProducts = ObservableList.of(_service.getAll());
  }

  @action
  void delete(String id) {
    _service.delete(id);
    getAll();
  }

  void add(Product product) {
    product.set_id(DateTime.now().toString());
    _service.add(product);
    getAll();
  }

  Product getById(String id) {
    return _service.getById(id);
  }

  void update(Product product) {
    _service.update(product);
    getAll();
  }
}
