import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final String? center;
  final String? dateCreated;
  final String? description;
  final List<String>? keywords;
  final String? mediaType;
  final String? nasaId;
  final String? secondaryCreator;
  final String? title;

  const Data({
    this.center,
    this.dateCreated,
    this.description,
    this.keywords,
    this.mediaType,
    this.nasaId,
    this.secondaryCreator,
    this.title,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        center: json['center'] as String?,
        dateCreated: json['date_created'] as String?,
        description: json['description'] as String?,
        keywords: json['keywords'] as List<String>?,
        mediaType: json['media_type'] as String?,
        nasaId: json['nasa_id'] as String?,
        secondaryCreator: json['secondary_creator'] as String?,
        title: json['title'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'center': center,
        'date_created': dateCreated,
        'description': description,
        'keywords': keywords,
        'media_type': mediaType,
        'nasa_id': nasaId,
        'secondary_creator': secondaryCreator,
        'title': title,
      };

  @override
  List<Object?> get props {
    return [
      center,
      dateCreated,
      description,
      keywords,
      mediaType,
      nasaId,
      secondaryCreator,
      title,
    ];
  }
}
