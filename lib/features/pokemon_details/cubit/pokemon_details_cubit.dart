import 'package:bloc/bloc.dart';
import 'package:domain/models/pokemon_details_business.dart';
import 'package:domain/models/pokemon_evolution_business.dart';
import 'package:domain/operations/pokedex/get_pokemon_details_by_id.dart';
import 'package:domain/operations/pokedex/get_pokemon_details_by_url.dart';
import 'package:domain/operations/pokedex/get_pokemon_evolutions_from_url.dart';
import 'package:domain/operations/pokedex/get_pokemon_specie.dart';
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
  final GetPokemonSpecie getPokemonSpecie;
  final GetPokemonEvolutionsFromUrl getPokemonEvolutionsFromUrl;

  PokemonDetailsCubit({
    required this.getPokemonDetailsById,
    required this.getPokemonDetailsByUrl,
    required this.getPokemonSpecie,
    required this.getPokemonEvolutionsFromUrl,
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
    final pokemonSpecies = await getPokemonSpecie(pokemon.species);
    final pokemonEvolutions =
        await getPokemonEvolutionsFromUrl(pokemonSpecies.evolutionChain);

    return PokemonDetailsViewModel(
      id: pokemon.id,
      name: pokemon.name.capitalize(),
      description: pokemon.description.capitalize(),
      stats: pokemonDetails.stats.map((e) => e.toViewModel()).toList(),
      backPicture: pokemonDetails.sprite.backDefault,
      frontPicture: pokemon.picture,
      evolutions:
          await _getEvolutions(pokemon.name.toLowerCase(), pokemonEvolutions),
      types: pokemon.types,
    );
  }

  Future<List<PokemonEvolutionViewModel>> _getEvolutions(
      String pokemonName, PokemonEvolutionBusiness evolutions) async {
    List<PokemonEvolutionViewModel> result = [];

    if (pokemonName != evolutions.species.name) {
      final evolutionId = _getIdFromUrl(evolutions.species.url);
      final evolutionDetails = await getPokemonDetailsById(evolutionId);
      List<PokemonEvolutionViewModel> evolvesTo =
          await _getDetailsFromEvolutions(
              pokemonName, evolutions.evolutionDetails);

      result.add(PokemonEvolutionViewModel(
        name: evolutions.species.name,
        picture: evolutionDetails.sprite.frontDefault,
        evolvesTo: evolvesTo,
      ));
    } else {
      final evolves = await _getDetailsFromEvolutions(
          pokemonName, evolutions.evolutionDetails);

      result.addAll(evolves);
    }

    return result;
  }

  Future<List<PokemonEvolutionViewModel>> _getDetailsFromEvolutions(
      String pokemonName, List<PokemonEvolutionBusiness> evolutions) async {
    List<PokemonEvolutionViewModel> result = [];

    for (final evolutionDetail in evolutions) {
      final pokemonEvolutions =
          await _getEvolutions(pokemonName, evolutionDetail);

      result.addAll(pokemonEvolutions);
    }

    return result;
  }

  int _getIdFromUrl(String url) {
    final urlFragments = url.split('/');

    return int.parse(urlFragments[urlFragments.length - 2]);
  }
}
