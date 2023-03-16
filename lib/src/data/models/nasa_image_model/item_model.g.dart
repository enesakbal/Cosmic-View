// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      href: json['href'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => LinkModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'href': instance.href,
      'data': instance.data,
      'links': instance.links,
    };
