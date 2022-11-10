import 'package:flutter/material.dart';
import 'package:pokedex/common/svg_icons.dart';
import 'package:pokedex/features/pokedex/pokemon_stats_view_model.dart';

const pokemonStats = PokemonStatsViewModel(
  type: PokemonStatsTypeViewModel.attack,
  value: 10,
  icon: LocalSvgIcons.attack,
  contentColor: Colors.green,
  backgroundColor: Colors.blue,
);
