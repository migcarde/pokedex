import 'package:flutter/widgets.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_display.dart';
import 'package:pokedex/features/pokedex/widgets/pokemon_type.dart';
import 'package:pokedex/widgets/crystal_card.dart';

class PokemonDetailsDesktopView extends StatelessWidget {
  const PokemonDetailsDesktopView({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokedexViewModel pokemon;

  @override
  Widget build(BuildContext context) {
    return CrystalCard(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          PokemonDisplay(
            picture: pokemon.picture,
          ),
          Text(pokemon.name),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: pokemon.types
                .map(
                  (type) => PokemonType(type: type),
                )
                .toList(),
          ),
          Text(pokemon.description),
          //! TODO: Add pokemon stats widget (we have to create it)
          //! Add pokemon evolutions card (could be easy to do using CrystalCard)
        ],
      ),
    );
  }
}
