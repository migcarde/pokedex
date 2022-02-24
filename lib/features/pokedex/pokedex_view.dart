import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/common/text_styles.dart';
import 'package:pokedex/features/pokedex/cubit/pokedex_cubit.dart';
import 'package:pokedex/common/string_extensions.dart';

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

                return ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0.8, sigmaY: 0.8),
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 36.0, right: 36.0, top: 40.0),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: Colors.white.withOpacity(0.4),
                        border: Border.all(
                          width: 1.5,
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -30,
                            right: -30,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(50.0),
                                ),
                                color: Colors.white.withOpacity(0.4),
                                border: Border.all(
                                  width: 1.5,
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              child: Image.network(
                                pokemon.picture,
                                width: 60.0,
                                height: 60.0,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                pokemon.name.capitalize(),
                                style: TextStyles.header(
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  pokemon.description.capitalize(),
                                  style: TextStyles.body(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
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
