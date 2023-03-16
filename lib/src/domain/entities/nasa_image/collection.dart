import 'package:equatable/equatable.dart';

import 'item.dart';
import 'link.dart';
import 'metadata.dart';

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

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        version: json['version'] as String?,
        href: json['href'] as String?,
        items: (json['items'] as List<dynamic>?)
            ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
            .toList(),
        metadata: json['metadata'] == null
            ? null
            : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
        links: (json['links'] as List<dynamic>?)
            ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'version': version,
        'href': href,
        'items': items?.map((e) => e.toJson()).toList(),
        'metadata': metadata?.toJson(),
        'links': links?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [version, href, items, metadata, links];
}
