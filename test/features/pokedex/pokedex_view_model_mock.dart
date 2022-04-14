import 'package:pokedex/features/pokedex/pokedex_view_model.dart';

const pokedexViewModelComplete = PokedexViewModel(
  name: 'name',
  picture: 'picture',
  description: 'description',
  types: ['types'],
);

const pokedexViewModelTypesEmpty = PokedexViewModel(
  name: 'name',
  picture: 'picture',
  description: 'description',
  types: [],
);

const pokedexViewModelCompleteTwoTags = PokedexViewModel(
  name: 'name',
  picture: 'picture',
  description: 'description',
  types: ['types', 'example'],
);

const pokedexViewModelList = [
  pokedexViewModelComplete,
  pokedexViewModelCompleteTwoTags,
  pokedexViewModelTypesEmpty,
];
