// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nasa_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NasaImageModel _$NasaImageModelFromJson(Map<String, dynamic> json) =>
    NasaImageModel(
      collection: json['collection'] == null
          ? null
          : CollectionModel.fromJson(
              json['collection'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NasaImageModelToJson(NasaImageModel instance) =>
    <String, dynamic>{
      'collection': instance.collection,
    };
