import 'package:domain/models/pokemon_details_business.dart';
import 'package:domain/models/pokemon_stats_business.dart';
import 'package:equatable/equatable.dart';

class PokemonDetailsResponse extends Equatable {
  final PokemonSpriteResponse sprite;
  final List<PokemonSlotTypeResponse> slots;
  final PokemonDetailsSpecieResponse specie;
  final List<PokemonStatsResponse> stats;
  final List<PokemonFormResponse> forms;

  const PokemonDetailsResponse({
    required this.sprite,
    required this.slots,
    required this.specie,
    required this.stats,
    required this.forms,
  });

  factory PokemonDetailsResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> slots = json['types'];
    final List<dynamic> stats = json['stats'];
    final List<dynamic> forms = json['forms'];

    return PokemonDetailsResponse(
      sprite: PokemonSpriteResponse.fromJson(json['sprites']),
      slots:
          slots.map((slot) => PokemonSlotTypeResponse.fromJson(slot)).toList(),
      specie: PokemonDetailsSpecieResponse.fromJson(json['species']),
      stats: stats.map((stat) => PokemonStatsResponse.fromJson(stat)).toList(),
      forms: forms.map((form) => PokemonFormResponse.fromJson(form)).toList(),
    );
  }

  @override
  List<Object?> get props => [sprite, slots];
}

class PokemonSpriteResponse extends Equatable {
  final String backDefault;
  final String frontDefault;

  const PokemonSpriteResponse({
    required this.backDefault,
    required this.frontDefault,
  });

  factory PokemonSpriteResponse.fromJson(Map<String, dynamic> json) =>
      PokemonSpriteResponse(
          backDefault: json['back_default'],
          frontDefault: json['front_default']);

  @override
  List<Object?> get props => [backDefault];
}

class PokemonSlotTypeResponse extends Equatable {
  final PokemonTypeResponse type;

  const PokemonSlotTypeResponse({required this.type});

  factory PokemonSlotTypeResponse.fromJson(Map<String, dynamic> json) =>
      PokemonSlotTypeResponse(type: PokemonTypeResponse.fromJson(json['type']));

  @override
  List<Object?> get props => [type];
}

class PokemonTypeResponse extends Equatable {
  final String name;

  const PokemonTypeResponse({required this.name});

  factory PokemonTypeResponse.fromJson(Map<String, dynamic> json) =>
      PokemonTypeResponse(name: json['name']);

  @override
  List<Object?> get props => [name];
}

class PokemonDetailsSpecieResponse extends Equatable {
  final String url;

  const PokemonDetailsSpecieResponse({required this.url});

  factory PokemonDetailsSpecieResponse.fromJson(Map<String, dynamic> json) =>
      PokemonDetailsSpecieResponse(url: json['url']);

  @override
  List<Object?> get props => [url];
}

class PokemonStatsResponse extends Equatable {
  final int baseStat;
  final int effort;
  final PokemonStatResponse stat;

  const PokemonStatsResponse({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory PokemonStatsResponse.fromJson(Map<String, dynamic> json) =>
      PokemonStatsResponse(
        baseStat: json['base_stat'],
        effort: json['effort'],
        stat: PokemonStatResponse.fromJson(json['stat']),
      );

  @override
  List<Object?> get props => [
        baseStat,
        effort,
        stat,
      ];
}

class PokemonStatResponse extends Equatable {
  final String name;
  final String url;

  const PokemonStatResponse({
    required this.name,
    required this.url,
  });

  factory PokemonStatResponse.fromJson(Map<String, dynamic> json) =>
      PokemonStatResponse(
        name: json['name'],
        url: json['url'],
      );

  @override
  List<Object?> get props => [name, url];
}

class PokemonFormResponse extends Equatable {
  final String name;
  final String url;

  const PokemonFormResponse({
    required this.name,
    required this.url,
  });

  @override
  List<Object?> get props => [name, url];

  factory PokemonFormResponse.fromJson(Map<String, dynamic> json) =>
      PokemonFormResponse(
        name: json['name'],
        url: json['url'],
      );
}

extension PokemonDetailsResponseExtensions on PokemonDetailsResponse {
  PokemonDetailsBusiness toDomain() => PokemonDetailsBusiness(
        sprite: sprite.toDomain(),
        slots: slots.map((slot) => slot.toDomain()).toList(),
        specie: specie.toDomain(),
        stats: stats.map((e) => e.toBusiness()).toList(),
        pokemonForm: forms.map((form) => form.toBusiness()).toList(),
      );
}

extension PokemonSpriteResponseExtensions on PokemonSpriteResponse {
  PokemonSpriteBusiness toDomain() => PokemonSpriteBusiness(
        backDefault: backDefault,
        frontDefault: frontDefault,
      );
}

extension PokemonSlotTypeResponseExtensions on PokemonSlotTypeResponse {
  PokemonSlotTypeBusiness toDomain() =>
      PokemonSlotTypeBusiness(type: type.toDomain());
}

extension PokemonTypeResponseExtensions on PokemonTypeResponse {
  PokemonTypeBusiness toDomain() => PokemonTypeBusiness(name: name);
}

extension PokemonSpecieResponseExtensions on PokemonDetailsSpecieResponse {
  PokemonDetailsSpecieBusiness toDomain() =>
      PokemonDetailsSpecieBusiness(url: url);
}

extension PokemonStatsResponseExtensions on PokemonStatsResponse {
  PokemonStatsBusiness toBusiness() => PokemonStatsBusiness(
        type: _getType(stat.name),
        value: baseStat,
      );

  PokemonStatsTypeBusiness _getType(String type) {
    switch (type) {
      case 'hp':
        return PokemonStatsTypeBusiness.hp;
      case 'attack':
        return PokemonStatsTypeBusiness.attack;
      case 'defense':
        return PokemonStatsTypeBusiness.defense;
      case 'special-attack':
        return PokemonStatsTypeBusiness.specialAttack;
      case 'special-defense':
        return PokemonStatsTypeBusiness.specialDefense;
      default:
        return PokemonStatsTypeBusiness.speed;
    }
  }
}

extension PokemonFormResponseExtensions on PokemonFormResponse {
  PokemonFormBusiness toBusiness() => PokemonFormBusiness(
        name: name,
        url: url,
      );
}
