import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/common/dimens.dart';
import 'package:pokedex/common/text_styles.dart';
import 'package:pokedex/features/pokedex/cubit/pokedex_cubit.dart';
import 'package:pokedex/features/pokedex/pokedex_desktop_view.dart';
import 'package:pokedex/features/pokedex/pokedex_mobile_view.dart';
import 'package:pokedex/widgets/crystal_card.dart';
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
            final nextPage = state.data.next;
            return ScreenAdapterWidget(
              mobileScreen: PokedexMobileView(
                pokemons: state.data.results,
                hasNextPage: nextPage != null,
                getMorePokemons: () {
                  if (nextPage != null) {
                    context.read<PokedexCubit>().getPokemonsByUrl(
                          nextPage,
                          state.data,
                        );
                  }
                },
              ),
              desktopScreen: PokedexDesktopView(
                  pokemons: state.data.results,
                  hasNextPage: nextPage != null,
                  getMorePokemons: () {
                    if (nextPage != null) {
                      context.read<PokedexCubit>().getPokemonsByUrl(
                            nextPage,
                            state.data,
                          );
                    }
                  }),
            );
          }
          return Center(
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
          );
        },
      ),
    );
  }
}
