// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      center: json['center'] as String?,
      dateCreated: json['date_created'] as String?,
      description: json['description'] as String?,
      keywords: (json['keywords'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      mediaType: json['media_type'] as String?,
      nasaId: json['nasa_id'] as String?,
      secondaryCreator: json['secondary_creator'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'center': instance.center,
      'date_created': instance.dateCreated,
      'description': instance.description,
      'keywords': instance.keywords,
      'media_type': instance.mediaType,
      'nasa_id': instance.nasaId,
      'secondary_creator': instance.secondaryCreator,
      'title': instance.title,
    };
