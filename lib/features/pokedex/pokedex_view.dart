import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/features/pokedex/cubit/pokedex_cubit.dart';

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
              itemBuilder: (context, index) {
                final pokemon = state.data.results[index];

                return ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0.8, sigmaY: 0.8),
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.white.withOpacity(0.4),
                          border: Border.all(
                              width: 1.5,
                              color: Colors.white.withOpacity(0.2))),
                      child: Row(
                        children: [
                          Image.network(pokemon.picture),
                          Text(
                            pokemon.name,
                            style: const TextStyle(color: Colors.white),
                          )
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
