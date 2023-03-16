import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/nasa_image/data.dart';

part 'data_model.g.dart';

@JsonSerializable()
class DataModel extends Equatable {
  final String? center;
  @JsonKey(name: 'date_created')
  final String? dateCreated;
  final String? description;
  final List<String>? keywords;
  @JsonKey(name: 'media_type')
  final String? mediaType;
  @JsonKey(name: 'nasa_id')
  final String? nasaId;
  @JsonKey(name: 'secondary_creator')
  final String? secondaryCreator;
  final String? title;

  const DataModel({
    this.center,
    this.dateCreated,
    this.description,
    this.keywords,
    this.mediaType,
    this.nasaId,
    this.secondaryCreator,
    this.title,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataModelToJson(this);

  Data toEntity() => Data(
        center: center,
        dateCreated: dateCreated,
        description: description,
        keywords: keywords,
        mediaType: mediaType,
        nasaId: nasaId,
        secondaryCreator: secondaryCreator,
        title: title,
      );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      center,
      dateCreated,
      description,
      keywords,
      mediaType,
      nasaId,
      secondaryCreator,
      title,
    ];
  }
}
