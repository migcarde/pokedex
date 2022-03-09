import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/features/pokedex/cubit/pokedex_cubit.dart';
import 'package:pokedex/features/pokedex/pokedex_desktop_view.dart';
import 'package:pokedex/features/pokedex/pokedex_mobile_view.dart';
import 'package:pokedex/widgets/screen_adapter_widget.dart';

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
            return ScreenAdapterWidget(
              mobileScreen: PokedexMobileView(
                pokemons: state.data.results,
              ),
              desktopScreen: PokedexDesktopView(pokemons: state.data.results),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
