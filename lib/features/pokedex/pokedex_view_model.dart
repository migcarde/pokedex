import 'package:domain/models/pokedex_business.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/common/pokemon_types.dart';
import 'package:pokedex/features/pokedex/pokemon_stats_view_model.dart';

class PokedexViewModel extends Equatable {
  final String name;
  final String picture;
  final String description;
  final List<PokemonTypes> types;
  final List<PokemonStatsViewModel> stats;
  final String evolutionChain;
  final String pokemonForm;

  const PokedexViewModel({
    required this.name,
    required this.picture,
    required this.description,
    required this.types,
    required this.stats,
    required this.evolutionChain,
    required this.pokemonForm,
  });

  @override
  List<Object?> get props => [
        name,
        picture,
        description,
        types,
        stats,
        evolutionChain,
        pokemonForm,
      ];
}

extension PokedexViewModelLocalDatabaseExtensions on PokedexBusiness {
  PokedexViewModel toViewModel() => PokedexViewModel(
        name: name,
        picture: picture,
        description: description,
        types: types.map((type) => type.getType()).toList(),
        stats: stats.map((stat) => stat.toViewModel()).toList(),
        evolutionChain: evolutionChain,
        pokemonForm: pokemonForm,
      );
}

extension PokedexViewModelExtensions on PokedexViewModel {
  PokedexBusiness toBusiness() => PokedexBusiness(
        name: name,
        picture: picture,
        description: description,
        types: types.map((type) => type.name).toList(),
        stats: stats.map((stat) => stat.toBusiness()).toList(),
        evolutionChain: evolutionChain,
        pokemonForm: pokemonForm,
      );
}
