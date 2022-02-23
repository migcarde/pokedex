import 'dart:convert';

import 'package:equatable/equatable.dart';

class OfficialArtwork extends Equatable {
  final String? frontDefault;

  const OfficialArtwork({this.frontDefault});

  factory OfficialArtwork.fromMap(Map<String, dynamic> data) {
    return OfficialArtwork(
      frontDefault: data['front_default'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'front_default': frontDefault,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OfficialArtwork].
  factory OfficialArtwork.fromJson(String data) {
    return OfficialArtwork.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OfficialArtwork] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [frontDefault];
}
