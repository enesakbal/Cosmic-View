import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/nasa_image/link.dart';

part 'link_model.g.dart';

@JsonSerializable()
class LinkModel extends Equatable {
  final String? href;
  final String? rel;
  final String? render;

  const LinkModel({this.href, this.rel, this.render});

  factory LinkModel.fromJson(Map<String, dynamic> json) =>
      _$LinkModelFromJson(json);

  Map<String, dynamic> toJson() => _$LinkModelToJson(this);

  Link toEntity() => Link(
        href: href,
        rel: rel,
        render: render,
      );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [href, rel, render];
}
