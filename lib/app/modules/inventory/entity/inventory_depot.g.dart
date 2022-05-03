// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_depot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryDepot _$InventoryDepotFromJson(Map<String, dynamic> json) =>
    InventoryDepot(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      image: json['image'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$InventoryDepotToJson(InventoryDepot instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'image': instance.image,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
