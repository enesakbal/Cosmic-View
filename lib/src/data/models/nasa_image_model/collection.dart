import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'item.dart';
import 'link.dart';
import 'metadata.dart';

part 'collection.g.dart';

@JsonSerializable()
class Collection extends Equatable {
  final String? version;
  final String? href;
  final List<Item>? items;
  final Metadata? metadata;
  final List<Link>? links;

  const Collection({
    this.version,
    this.href,
    this.items,
    this.metadata,
    this.links,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return _$CollectionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CollectionToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [version, href, items, metadata, links];
}
