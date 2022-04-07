// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      json['id'] as String,
      json['title'] as String,
      json['qtde'] as int,
      (json['price'] as num).toDouble(),
      json['imageUrl'] as String,
      (json['discount'] as num).toDouble(),
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'qtde': instance.qtde,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'discount': instance.discount,
    };
