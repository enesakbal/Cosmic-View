import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'metadata.g.dart';

@JsonSerializable()
class Metadata extends Equatable {
  @JsonKey(name: 'total_hits')
  final int? totalHits;

  const Metadata({this.totalHits});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return _$MetadataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MetadataToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [totalHits];
}
