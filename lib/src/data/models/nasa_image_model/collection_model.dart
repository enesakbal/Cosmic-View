import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/nasa_image/collection.dart';
import 'item_model.dart';

import 'link_model.dart';
import 'metadata_model.dart';

part 'collection_model.g.dart';

@JsonSerializable()
class CollectionModel extends Equatable {
  final String? version;
  final String? href;
  final List<ItemModel>? items;
  final MetadataModel? metadata;
  final List<LinkModel>? links;

  const CollectionModel({
    this.version,
    this.href,
    this.items,
    this.metadata,
    this.links,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return _$CollectionModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CollectionModelToJson(this);

  Collection toEntity() => Collection(
        href: href,
        items: items?.map((e) => e.toEntity()).toList(),
        links: links?.map((e) => e.toEntity()).toList(),
        metadata: metadata?.toEntity(),
        version: version,
      );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [version, href, items, metadata, links];
}
