import 'package:equatable/equatable.dart';

class Metadata extends Equatable {
  final int? totalHits;

  const Metadata({this.totalHits});

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        totalHits: json['total_hits'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'total_hits': totalHits,
      };

  @override
  List<Object?> get props => [totalHits];
}
