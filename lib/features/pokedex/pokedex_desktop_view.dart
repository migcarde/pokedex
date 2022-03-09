import 'package:flutter/widgets.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';
import 'package:pokedex/features/pokedex/widgets/pokedex_desktop_card.dart';

class PokedexDesktopView extends StatelessWidget {
  const PokedexDesktopView({
    Key? key,
    required this.pokemons,
  }) : super(key: key);

  final List<PokedexViewModel> pokemons;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: pokemons
          .map(
            (pokemon) => Flexible(
              flex: 3,
              child: PokedexDesktopCard(pokemon: pokemon),
            ),
          )
          .toList(),
    );
  }
}
