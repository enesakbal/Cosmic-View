import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/nasa_image/metadata.dart';

part 'metadata_model.g.dart';

@JsonSerializable()
class MetadataModel extends Equatable {
  @JsonKey(name: 'total_hits')
  final int? totalHits;

  const MetadataModel({this.totalHits});

  factory MetadataModel.fromJson(Map<String, dynamic> json) {
    return _$MetadataModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MetadataModelToJson(this);

  Metadata toEntity() => Metadata(totalHits: totalHits);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [totalHits];
}
