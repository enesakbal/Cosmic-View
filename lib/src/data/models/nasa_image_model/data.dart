import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data extends Equatable {
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

  const Data({
    this.center,
    this.dateCreated,
    this.description,
    this.keywords,
    this.mediaType,
    this.nasaId,
    this.secondaryCreator,
    this.title,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

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
