import 'package:flutter/widgets.dart';

import '../../entity/inventory_depo.dart';
import 'inventory_depos_view_i.dart';

class InventoryDeposView extends StatefulWidget{
  const InventoryDeposView({Key? key}) : super(key: key);

  @override
  State<InventoryDeposView> createState() => _InventoryDeposViewState();

}

class _InventoryDeposViewState extends State<InventoryDeposView>  implements
    InventoryDeposViewI {



  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  List<InventoryDepo> onLoadDepos(List<InventoryDepo> listDepos) {
    return listDepos;
  }
}