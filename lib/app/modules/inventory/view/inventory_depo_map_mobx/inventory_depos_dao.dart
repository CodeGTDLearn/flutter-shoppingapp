import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/properties/db_urls.dart';
import '../../entity/inventory_depo.dart';
import 'inventory_depos_dao_i.dart';

class InventoryDeposDao implements InventoryDeposDaoI {
  @override
  Future<List<InventoryDepo>> getDeposData() async {
    var uri = Uri.parse(DEPOTS_URL);
    var response = await http.get(uri, headers: {"Accept": "application/json"});
    final body = json.decode(response.body);
    return body.map<InventoryDepo>(InventoryDepo.fromJson).toList();
  }
}