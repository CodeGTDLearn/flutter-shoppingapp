import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/config/titlesIcons.dart';
import 'package:shopingapp/service_stores/OrdersStore.dart';
import 'package:shopingapp/widgets/OrderCollapsableTile.dart';

class OrderView extends StatefulWidget {
  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final _store = Modular.get<IOrdersStore>();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ORD_TITLE_PAGE)),
      drawer: null,
      body: Container(
          child: ListView.builder(
        itemCount: _store.getAll().length,
        itemBuilder: (ctx, item) => OrderCollapsableTile(_store.getAll()[item]),
      )),
    );
  }
}