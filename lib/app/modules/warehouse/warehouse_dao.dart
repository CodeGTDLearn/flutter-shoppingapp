import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/properties/db_urls.dart';
import 'warehouse.dart';
import 'warehouse_dao_i.dart';
import 'warehouse_exception.dart';

class WarehouseDao implements WarehouseDaoI {
  @override
  Future<List<Warehouse>> getWarehouses() async {
    var uri = Uri.parse(WAREHOUSES_URL);
    var response = await http.get(uri, headers: {"Accept": "application/json"});
    final stringBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode != 200) {
      print(response.reasonPhrase);
      throw WarehouseException("StatusCode:$statusCode, Error:${response.reasonPhrase}");
    }

    final json_From_StringBody = json.decode(stringBody);
    var list_From_JsonResulting =
        json_From_StringBody.map<Warehouse>(Warehouse.fromJson).toList();

    return list_From_JsonResulting;
  }
}