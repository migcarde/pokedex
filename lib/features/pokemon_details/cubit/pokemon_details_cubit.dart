import 'package:bloc/bloc.dart';
import 'package:domain/models/pokemon_details_business.dart';
import 'package:domain/models/pokemon_evolution_business.dart';
import 'package:domain/operations/pokedex/get_pokemon_details_by_id.dart';
import 'package:domain/operations/pokedex/get_pokemon_details_by_url.dart';
import 'package:domain/operations/pokedex/get_pokemon_evolutions.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/common/string_extensions.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';
import 'package:pokedex/features/pokedex/pokemon_stats_view_model.dart';
import 'package:pokedex/features/pokemon_details/pokemon_details_view_model.dart';
import 'package:pokedex/features/pokemon_details/pokemon_evolution_view_model.dart';

part 'pokemon_details_state.dart';

class PokemonDetailsCubit extends Cubit<PokemonDetailsState> {
  final GetPokemonDetailsById getPokemonDetailsById;
  final GetPokemonDetailsByUrl getPokemonDetailsByUrl;
  final GetPokemonEvolutions getPokemonEvolutions;

  PokemonDetailsCubit({
    required this.getPokemonDetailsById,
    required this.getPokemonDetailsByUrl,
    required this.getPokemonEvolutions,
  }) : super(const PokemonDetailsState());

  void init(PokedexViewModel pokemon) async {
    try {
      final pokemonDetails = await _getPokemonDetails(pokemon);
      emit(
        state.copyWith(
            status: PokemonDetailsStatus.success,
            pokemonDetails: pokemonDetails),
      );
    } catch (e) {
      emit(
        state.copyWith(
            status: PokemonDetailsStatus.failure,
            message: 'Opps, something was wrong, please, try again later.'),
      );
    }
  }

  Future<PokemonDetailsViewModel> _getPokemonDetails(
      PokedexViewModel pokemon) async {
    final PokemonDetailsBusiness pokemonDetails =
        await getPokemonDetailsById(pokemon.id);
    final pokemonEvolutions = await getPokemonEvolutions(pokemon.id);

    return PokemonDetailsViewModel(
      id: pokemon.id,
      name: pokemon.name.capitalize(),
      description: pokemon.description.capitalize(),
      stats: pokemonDetails.stats.map((e) => e.toViewModel()).toList(),
      backPicture: pokemonDetails.sprite.backDefault,
      frontPicture: pokemon.picture,
      evolutions: await _getEvolutions(pokemonEvolutions.evolutionDetails),
      types: pokemon.types,
    );
  }

  Future<List<PokemonEvolutionViewModel>> _getEvolutions(
      List<PokemonEvolutionBusiness> evolutions) async {
    List<PokemonEvolutionViewModel> result = [];
    for (var evolution in evolutions) {
      final evolutionId = _getIdFromUrl(evolution.species.url);
      final evolutionDetails = await getPokemonDetailsById(evolutionId);

      result.add(PokemonEvolutionViewModel(
        name: evolution.species.name,
        picture: evolutionDetails.sprite.frontDefault,
        evolvesTo: await _getEvolutions(evolution.evolutionDetails),
      ));
    }

    return result;
  }

  int _getIdFromUrl(String url) {
    final urlFragments = url.split('/');

    return int.parse(urlFragments[urlFragments.length - 2]);
  }
}
