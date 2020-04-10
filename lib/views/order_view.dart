import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/service_stores/OrdersStore.dart';

class OrderView extends StatefulWidget {
  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final store = Modular.get<OrdersStore>();

  @override
  void initState() {}


  @override
  Widget build(BuildContext context) {
    return Container();
  }

}
