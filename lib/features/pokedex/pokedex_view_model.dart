import 'package:domain/models/pokedex_business.dart';
import 'package:domain/models/pokemon_business.dart';
import 'package:domain/models/pokemon_stats_business.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/common/pokemon_types.dart';
import 'package:pokedex/common/string_extensions.dart';
import 'package:pokedex/features/pokedex/pokemon_stats_view_model.dart';

class PokedexViewModel extends Equatable {
  final String name;
  final String picture;
  final String description;
  final List<PokemonTypes> types;
  final List<PokemonStatsViewModel> stats;

  const PokedexViewModel({
    required this.name,
    required this.picture,
    required this.description,
    required this.types,
    required this.stats,
  });

  @override
  List<Object?> get props => [name, picture];
}

extension PokedexViewModelBusinessExtension on PokemonBusiness {
  PokedexViewModel toViewModel(
    String picture,
    List<String> types,
    String description,
    List<PokemonStatsBusiness> stats,
  ) =>
      PokedexViewModel(
          name: name.capitalize(),
          picture: picture,
          description: description.capitalize(),
          types: types.map((type) => type.getType()).toList(),
          stats: stats.map((stat) => stat.toViewModel()).toList());
}

extension PokedexViewModelLocalDatabaseExtensions on PokedexBusiness {
  PokedexViewModel toViewModel() => PokedexViewModel(
      name: name,
      picture: picture,
      description: description,
      types: types.map((type) => type.getType()).toList(),
      stats: stats.map((stat) => stat.toViewModel()).toList());
}

extension PokedexViewModelExtensions on PokedexViewModel {
  PokedexBusiness toBusiness() => PokedexBusiness(
        name: name,
        picture: picture,
        description: description,
        types: types.map((type) => type.name).toList(),
        stats: stats.map((stat) => stat.toBusiness()).toList(),
      );
}
