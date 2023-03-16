import 'package:equatable/equatable.dart';

import 'data.dart';
import 'link.dart';

class Item extends Equatable {
  final String? href;
  final List<Data>? data;
  final List<Link>? links;

  const Item({this.href, this.data, this.links});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        href: json['href'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
            .toList(),
        links: (json['links'] as List<dynamic>?)
            ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'href': href,
        'data': data?.map((e) => e.toJson()).toList(),
        'links': links?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [href, data, links];
}
