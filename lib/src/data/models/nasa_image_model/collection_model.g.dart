// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionModel _$CollectionModelFromJson(Map<String, dynamic> json) =>
    CollectionModel(
      version: json['version'] as String?,
      href: json['href'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] == null
          ? null
          : MetadataModel.fromJson(json['metadata'] as Map<String, dynamic>),
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => LinkModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CollectionModelToJson(CollectionModel instance) =>
    <String, dynamic>{
      'version': instance.version,
      'href': instance.href,
      'items': instance.items,
      'metadata': instance.metadata,
      'links': instance.links,
    };
