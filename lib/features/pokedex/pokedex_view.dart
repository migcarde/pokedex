import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/common/box_decoration_styles.dart';
import 'package:pokedex/common/dimens.dart';
import 'package:pokedex/common/text_styles.dart';
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
          return Center(
            child: Container(
                padding: const EdgeInsets.all(mediumBigDimen),
                decoration: BoxDecorationStyles.crystal(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Cargando...',
                      style: TextStyles.bold(
                          fontSize: 36.0, textColor: Colors.white),
                    ),
                    Image.asset('assets/pokemon_loader.gif'),
                  ],
                )),
          );
        },
      ),
    );
  }
}
