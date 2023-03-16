import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'data.dart';
import 'link.dart';

part 'item.g.dart';

@JsonSerializable()
class Item extends Equatable {
  final String? href;
  final List<Data>? data;
  final List<Link>? links;

  const Item({this.href, this.data, this.links});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [href, data, links];
}
