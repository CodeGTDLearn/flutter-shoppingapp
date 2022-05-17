import 'package:json_annotation/json_annotation.dart';

part 'warehouse.g.dart';

// flutter pub run build_runner watch
// flutter pub run build_runner build
// flutter pub run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class Warehouse {
  String id;
  String name;
  String address;
  String image;
  double latitude;
  double longitude;

  Warehouse({
    required this.id,
    required this.name,
    required this.address,
    required this.image,
    required this.latitude,
    required this.longitude,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) => _$WarehouseFromJson(json);

  Map<String, dynamic> toJson() => _$WarehouseToJson(this);
}