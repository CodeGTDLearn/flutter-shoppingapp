import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'warehouse.dart';
import 'warehouse_presenter.dart';
//https://youtu.be/I2AgSDAEZSE
//50:31 - construindo o presenter
class WarehouseView extends StatefulWidget {
  const WarehouseView({Key? key}) : super(key: key);

  @override
  State<WarehouseView> createState() => _WarehouseViewState();
}

class _WarehouseViewState extends State<WarehouseView> implements WarehouseViewContractI {
  late WarehousePresenter _presenter;
  late List<Warehouse> _warehouses;


  _WarehouseViewState(){
    _presenter = WarehousePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter.loadWarehouses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('WareHouses')),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_warehousesListView(_warehouses)],
        )));
  }

  _warehousesListView(List<Warehouse> _warehouses) => Expanded(
      child: Card(
          margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Scrollbar(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return Column(children: <Widget>[
                      ListTile(
                          leading: Icon(
                            Icons.account_circle,
                            color: Colors.lightBlueAccent,
                            size: 40.0,
                          ),
                          title: Text(
                            _warehouses[index].name.toUpperCase(),
                            style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(_warehouses[index].address),
                          onTap: () {}),
                      Divider(height: 5.0)
                    ]);
                  },
                  itemCount: _warehouses.length))));

  @override
  void onLoadWarehouses(List<Warehouse> warehouses) {
    setState(() {
      _warehouses = warehouses;
    });
  }
}