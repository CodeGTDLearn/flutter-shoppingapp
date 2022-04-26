// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      stockQtde: json['stockQtde'] as int,
      code: json['code'] as String? ?? "",
      isFavorite: json['isFavorite'] as bool? ?? false,
      discount: (json['discount'] as num?)?.toDouble() ?? 0,
      arrivalDate: json['arrivalDate'] == null
          ? null
          : DateTime.parse(json['arrivalDate'] as String),
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'isFavorite': instance.isFavorite,
      'code': instance.code,
      'stockQtde': instance.stockQtde,
      'discount': instance.discount,
      'arrivalDate': instance.arrivalDate.toIso8601String(),
      'expirationDate': instance.expirationDate.toIso8601String(),
    };
