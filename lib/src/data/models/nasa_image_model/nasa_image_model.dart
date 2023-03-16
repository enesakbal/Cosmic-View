import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/nasa_image/nasa_image.dart';
import 'collection.dart';

part 'nasa_image_model.g.dart';

@JsonSerializable()
class NasaImageModel extends Equatable {
  final Collection? collection;

  const NasaImageModel({this.collection});

  factory NasaImageModel.fromJson(Map<String, dynamic> json) {
    return _$NasaImageModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NasaImageModelToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [collection];
}
