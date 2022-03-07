import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/common/dimens.dart';
import 'package:pokedex/common/text_styles.dart';
import 'package:pokedex/features/pokedex/cubit/pokedex_cubit.dart';
import 'package:pokedex/common/string_extensions.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';

class PokedexView extends StatelessWidget {
  const PokedexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<PokedexCubit>(),
      child: BlocBuilder<PokedexCubit, PokedexState>(
        builder: (context, state) {
          if (state is PokedexInitial) {
            context.read<PokedexCubit>().getPokemons();
          } else if (state is PokedexData) {
            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final pokemon = state.data.results[index];

                return PokedexCard(pokemon: pokemon);
              },
              itemCount: state.data.results.length,
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

class PokedexCard extends StatelessWidget {
  const PokedexCard({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokedexViewModel pokemon;

  static const double blurSigma = 40.0;
  static const double boxOpacity = 0.2;
  static const double pokemonBoxPositioned = -30.0;
  static const double pokemonPictureDimen = 60.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: veryLargeDimen,
        right: veryLargeDimen,
        top: veryLargeDimen,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(mediumDimen),
        ),
        color: Colors.black.withOpacity(boxOpacity),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: double.infinity,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.all(Radius.circular(mediumDimen)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: bigTinyDimen,
                        left: mediumDimen,
                        right: mediumDimen,
                      ),
                      child: Text(
                        pokemon.name.capitalize(),
                        style: TextStyles.header(
                          textColor: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: bigTinyDimen,
                        left: mediumDimen,
                        right: mediumDimen,
                      ),
                      child: Text(
                        pokemon.description.capitalize(),
                        style: TextStyles.body(textColor: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: bigTinyDimen,
                        horizontal: mediumDimen,
                      ),
                      child: Wrap(
                        spacing: mediumDimen,
                        children: pokemon.types
                            .map((type) => PokemonType(type: type))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: pokemonBoxPositioned,
            right: pokemonBoxPositioned,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(circularRadius),
                ),
                color: Colors.black.withOpacity(boxOpacity),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(circularRadius),
                ),
                child: BackdropFilter(
                  filter:
                      ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
                  child: Image.network(
                    pokemon.picture,
                    width: pokemonPictureDimen,
                    height: pokemonPictureDimen,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PokemonType extends StatelessWidget {
  const PokemonType({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  static const double blurSigma = 5.0;
  static const double boxOpacity = 0.2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(circularRadius),
        ),
        color: Colors.white.withOpacity(boxOpacity),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: mediumDimen,
        ),
        child: Text(
          type,
          style: TextStyles.bold(textColor: Colors.white),
        ),
      ),
    );
  }
}
