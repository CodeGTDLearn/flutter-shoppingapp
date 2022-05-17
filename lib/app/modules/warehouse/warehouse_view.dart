import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'warehouse.dart';
import 'warehouse_presenter.dart';
import 'warehouse_view_i.dart';

class WarehouseView extends StatefulWidget {
  const WarehouseView({Key? key}) : super(key: key);

  @override
  State<WarehouseView> createState() => _WarehouseViewState();
}

class _WarehouseViewState extends State<WarehouseView> implements WarehouseViewI {
  late WarehousePresenter _presenter;

  int _counterObs = 0;

  @override
  void initState() {
    super.initState();
    _presenter = WarehousePresenter(this);
    // _presenter.loadWarehousesObsAction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Observer(
                builder: (_) => Text(
                  '${_presenter.intObs.value}',
                  style: const TextStyle(fontSize: 20),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementIntObsAction,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void incrementIntObsAction() {
    _presenter.incrementIntObsAction();
  }

  @override
  List<Warehouse> onLoadWarehouses() {
    // TODO: implement onLoadWarehouses
    throw UnimplementedError();
  }
}