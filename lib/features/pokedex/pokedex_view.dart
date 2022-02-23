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
              itemBuilder: (context, index) => Text(
                  '${state.data.results[index].name} ${state.data.results[index].picture}'),
              itemCount: state.data.results.length,
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
