import 'package:equatable/equatable.dart';

import 'collection.dart';

class NasaImage extends Equatable {
  final Collection? collection;

  const NasaImage({this.collection});

  factory NasaImage.fromJson(Map<String, dynamic> json) => NasaImage(
        collection: json['collection'] == null
            ? null
            : Collection.fromJson(json['collection'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'collection': collection?.toJson(),
      };

  @override
  List<Object?> get props => [collection];
}
