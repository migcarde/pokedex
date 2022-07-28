import 'package:equatable/equatable.dart';

class BaseUrlResponse extends Equatable {
  final String url;

  const BaseUrlResponse({required this.url});

  @override
  List<Object?> get props => [url];

  factory BaseUrlResponse.fromJson(Map<String, dynamic> json) =>
      BaseUrlResponse(url: json['url']);
}
