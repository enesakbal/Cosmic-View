import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'link.g.dart';

@JsonSerializable()
class Link extends Equatable {
  final String? href;
  final String? rel;
  final String? render;

  const Link({this.href, this.rel, this.render});

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  Map<String, dynamic> toJson() => _$LinkToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [href, rel, render];
}
