import 'package:flutter/material.dart';
import 'package:pokedex/common/dimens.dart';
import 'package:pokedex/common/text_styles.dart';
import 'package:pokedex/widgets/crystal_card.dart';

class PokemonLoader extends StatelessWidget {
  const PokemonLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.largeDimen),
        child: CrystalCard(
            child: Padding(
          padding: const EdgeInsets.all(Dimens.largeDimen),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Cargando...',
                style: TextStyles.bold(
                    fontSize: Dimens.largeText, textColor: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(top: Dimens.bigDimen),
                child: Image.asset('assets/pokemon_loader.gif'),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
