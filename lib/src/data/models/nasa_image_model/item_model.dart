import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/nasa_image/item.dart';
import 'data_model.dart';
import 'link_model.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel extends Equatable {
  final String? href;
  final List<DataModel>? data;
  final List<LinkModel>? links;

  const ItemModel({this.href, this.data, this.links});

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  Item toEntity() => Item(
        data: data?.map((e) => e.toEntity()).toList(),
        href: href,
        links: links?.map((e) => e.toEntity()).toList(),
      );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [href, data, links];
}
