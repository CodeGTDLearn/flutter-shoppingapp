import 'package:flutter_modular/flutter_modular.dart';

import '../../overview/product.dart';
import '../../overview/repo/i_overview_repo.dart';
import 'i_managed_products_service.dart';

class ManagedProductsService implements IManagedProductsService {
  final _repo = Modular.get<IOverviewRepo>();

  @override
  List<Product> getAll() {
    return _repo.getAll().toList();
  }

  @override
  int managedProductsQtde() {
    return _repo.getAll().length;
  }

  @override
  Product getById(String id) {
    return _repo.getById(id);
  }

  @override
  void add(Product product) {
    product.set_id(DateTime.now().toString());
    _repo.add(product);
  }

  @override
  void update(Product product) {
    _repo.update(product);
  }

  @override
  void delete(String id) {
    _repo.delete(id);
  }
}
