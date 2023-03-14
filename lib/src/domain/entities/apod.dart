import 'package:equatable/equatable.dart';

class APOD extends Equatable {
  final String? copyright;
  final String? date;
  final String? explanation;
  final String? hdurl;
  final String? mediaType;
  final String? serviceVersion;
  final String? title;
  final String? url;

  const APOD({
    this.copyright,
    this.date,
    this.explanation,
    this.hdurl,
    this.mediaType,
    this.serviceVersion,
    this.title,
    this.url,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        copyright,
        date,
        explanation,
        hdurl,
        mediaType,
        serviceVersion,
        title,
        url
      ];
}
