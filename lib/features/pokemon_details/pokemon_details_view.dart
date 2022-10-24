import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/features/pokedex/pokedex_view_model.dart';
import 'package:pokedex/features/pokemon_details/cubit/pokemon_details_cubit.dart';
import 'package:pokedex/features/pokemon_details/pokemon_details_desktop_view.dart';
import 'package:pokedex/features/pokemon_details/pokemon_details_mobile_view.dart';
import 'package:pokedex/widgets/dialog_adapter_widget.dart';
import 'package:pokedex/widgets/pokemon_loader.dart';
import 'package:pokedex/widgets/something_wrong_content.dart';

class PokemonDetailsView extends StatelessWidget {
  const PokemonDetailsView({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokedexViewModel pokemon;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<PokemonDetailsCubit>(),
      child: BlocBuilder<PokemonDetailsCubit, PokemonDetailsState>(
        builder: (context, state) {
          switch (state.status) {
            case PokemonDetailsStatus.loading:
              context.read<PokemonDetailsCubit>().init(pokemon);
              return const PokemonLoader();
            case PokemonDetailsStatus.success:
              return DialogAdapterWidget(
                desktopDialog: PokemonDetailsDesktopView(
                  pokemonDetails: state.pokemonDetails!,
                ),
                mobileDialog: PokemonDetailsMobileView(
                  pokemonDetails: state.pokemonDetails!,
                ),
              );
            case PokemonDetailsStatus.failure:
              return const SomethingWrongContent();
          }
        },
      ),
    );
  }
}
