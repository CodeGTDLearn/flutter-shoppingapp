import 'dart:math';

import 'package:shopingapp/app/modules/inventory/entity/inventory_depot.dart';

import '../app_tests_properties.dart';

class DepotDataBuilder {
  final _randomPosition = Random().nextInt(TEST_IMAGE_URL_MAP.length);

  InventoryDepot DepotWithId() {
    return InventoryDepot(
      id: "1",
      name: "Five Guys 1",
      address: "324 W Hunt Club Rd",
      image: "https://goo.gl/maps/Nk3AD3XroGFfzXRv7",
      latitude: 45.3385436,
      longitude: -75.7145955,
    );
  }

  List<InventoryDepot> ListDepot() {
    var returnList = <InventoryDepot>[];
    var _first = InventoryDepot(
      id: "1",
      name: "Five Guys 1",
      address: "324 W Hunt Club Rd",
      image: "https://goo.gl/maps/Nk3AD3XroGFfzXRv7",
      latitude: 45.3385436,
      longitude: -75.7145955,
    );
    var _second = InventoryDepot(
      id: "2",
      name: "Five Guys 2",
      address: "525 Industrial Blvd, Ottawa, ON K1G 3S2",
      image: "https://goo.gl/maps/7Qufd334NDm1AWMc9",
      latitude: 45.4119736,
      longitude: -75.6459499,
    );
    var _third = InventoryDepot(
      id: "3",
      name: "Five Guys 3",
      address: "1181 Greenbank Rd, Nepean, ON K2J 4Y6",
      image: "https://goo.gl/maps/ynJwdvnAid3xeTAM8",
      latitude: 45.2743862,
      longitude: -75.747975,
    );
    returnList.addAll([_first, _second, _third]);
    return returnList;
  }
}