import 'package:json_annotation/json_annotation.dart';

part 'inventory_depot.g.dart';

// flutter pub run build_runner watch
// flutter pub run build_runner build
// flutter pub run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class InventoryDepot {
  String id;
  String name;
  String address;
  String image;
  double latitude;
  double longitude;

  InventoryDepot({
    required this.id,
    required this.name,
    required this.address,
    required this.image,
    required this.latitude,
    required this.longitude,
  });

  factory InventoryDepot.fromJson(Map<String, dynamic> json) => _$InventoryDepotFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryDepotToJson(this);
}