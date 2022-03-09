import 'package:flutter/material.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';
import 'package:pokedex/features/pokedex/widgets/pokedex_mobile_card.dart';

class PokedexMobileView extends StatelessWidget {
  const PokedexMobileView({
    Key? key,
    required this.pokemons,
  }) : super(key: key);

  final List<PokedexViewModel> pokemons;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];

        return PokedexMobileCard(pokemon: pokemon);
      },
      itemCount: pokemons.length,
    );
  }
}
