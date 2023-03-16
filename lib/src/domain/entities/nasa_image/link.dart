import 'package:equatable/equatable.dart';

class Link extends Equatable {
  final String? href;
  final String? rel;
  final String? render;

  const Link({
    this.href,
    this.rel,
    this.render,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        href: json['href'] as String?,
        rel: json['rel'] as String?,
        render: json['render'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'href': href,
        'rel': rel,
        'render': render,
      };

  @override
  List<Object?> get props => [href, rel, render];
}
