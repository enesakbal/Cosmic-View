import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/apod.dart';

part 'apod_model.g.dart';

@JsonSerializable()
class APODModel extends Equatable {
  final String? copyright;
  final String? date;
  final String? explanation;
  final String? hdurl;
  @JsonKey(name: 'media_type')
  final String? mediaType;
  @JsonKey(name: 'service_version')
  final String? serviceVersion;
  final String? title;
  final String? url;

  const APODModel({
    this.copyright,
    this.date,
    this.explanation,
    this.hdurl,
    this.mediaType,
    this.serviceVersion,
    this.title,
    this.url,
  });

  APOD toEntity() {
    return APOD(
      copyright: copyright,
      date: date,
      explanation: explanation,
      hdurl: hdurl,
      mediaType: mediaType,
      serviceVersion: serviceVersion,
      title: title,
      url: url,
    );
  }

  factory APODModel.fromJson(Map<String, dynamic> json) {
    return _$APODModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$APODModelToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        copyright,
        date,
        explanation,
        hdurl,
        mediaType,
        serviceVersion,
        title,
        url
      ];
}
