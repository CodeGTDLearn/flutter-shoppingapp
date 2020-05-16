import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/entities/product.dart';
import 'package:shopingapp/repositories/productsRepoInt.dart';

part 'managedProductsStore.g.dart';

class ManagedProductsStore = ManagedProductsStoreInt with _$ManagedProductsStore;

abstract class ManagedProductsStoreInt with Store {
  final _repo = Modular.get<ProductsRepoInt>();

  @observable
  int qtdeManagedProducts = 0;

  List<Product> getAll(){
    return _repo.getAll();
  }

  void calcQtdeManagedProducts(){
    qtdeManagedProducts = _repo.getAll().length;
  }

}
