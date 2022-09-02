import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/features/pokedex/cubit/pokedex_cubit.dart';
import 'package:pokedex/features/pokedex/pokedex_desktop_view.dart';
import 'package:pokedex/features/pokedex/pokedex_mobile_view.dart';
import 'package:pokedex/widgets/pokemon_loader.dart';
import 'package:pokedex/widgets/screen_adapter_widget.dart';

class PokedexView extends StatelessWidget {
  const PokedexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var offset = 0;
    return BlocProvider(
      create: (context) => GetIt.I<PokedexCubit>(),
      child: BlocBuilder<PokedexCubit, PokedexState>(
        builder: (context, state) {
          if (state is PokedexInitial) {
            context.read<PokedexCubit>().getPokemons();
          } else if (state is PokedexData) {
            offset = state.data.count;
            final nextPage = state.data.next;
            return ScreenAdapterWidget(
              mobileScreen: PokedexMobileView(
                pokemons: state.data.results,
                getMorePokemons: () {
                  if (nextPage != null) {
                    context.read<PokedexCubit>().getPokemonsByUrl(
                          nextPage,
                          state.data,
                        );
                  } else {
                    context
                        .read<PokedexCubit>()
                        .getMorePokemons(state.data, offset: offset);
                  }
                },
              ),
              desktopScreen: PokedexDesktopView(
                  pokemons: state.data.results,
                  getMorePokemons: () {
                    if (nextPage != null) {
                      context.read<PokedexCubit>().getPokemonsByUrl(
                            nextPage,
                            state.data,
                          );
                    } else {
                      context
                          .read<PokedexCubit>()
                          .getMorePokemons(state.data, offset: offset);
                    }
                  }),
            );
          }
          return const PokemonLoader();
        },
      ),
    );
  }
}
