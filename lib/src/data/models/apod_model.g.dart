// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apod_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APODModel _$APODModelFromJson(Map<String, dynamic> json) => APODModel(
      copyright: json['copyright'] as String?,
      date: json['date'] as String?,
      explanation: json['explanation'] as String?,
      hdurl: json['hdurl'] as String?,
      mediaType: json['media_type'] as String?,
      serviceVersion: json['service_version'] as String?,
      title: json['title'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$APODModelToJson(APODModel instance) => <String, dynamic>{
      'copyright': instance.copyright,
      'date': instance.date,
      'explanation': instance.explanation,
      'hdurl': instance.hdurl,
      'media_type': instance.mediaType,
      'service_version': instance.serviceVersion,
      'title': instance.title,
      'url': instance.url,
    };
