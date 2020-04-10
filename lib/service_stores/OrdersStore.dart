import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/repositories/i_orders_repo.dart';

part 'OrdersStore.g.dart';

class OrdersStore = IOrdersStore with _$OrdersStore;

abstract class IOrdersStore with Store {
  final _repo = Modular.get<IOrdersRepo>();
    
}



