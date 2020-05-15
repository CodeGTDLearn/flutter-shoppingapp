import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../config/titlesIconsMessages/views/ordersView.dart';
import '../service_stores/ordersStore.dart';
import '../widgets/orderCollapsableTile.dart';

class OrderView extends StatefulWidget {
  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final _store = Modular.get<OrdersStoreInt>();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(ORD_TIT_PAGE)),
        drawer: null,
        body: Container(
            child: ListView.builder(
                itemCount: _store.getAll().length,
                itemBuilder: (ctx, item) => OrderCollapsableTile(_store.getAll()[item]))));
  }
}
