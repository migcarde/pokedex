import 'package:pokedex/features/pokedex/pokedex_view_model.dart';

const pokedexViewModelComplete = PokedexViewModel(
  name: 'name',
  picture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  description: 'description',
  types: ['types'],
);

const pokedexViewModelTypesEmpty = PokedexViewModel(
  name: 'name',
  picture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  description: 'description',
  types: [],
);

const pokedexViewModelCompleteTwoTags = PokedexViewModel(
  name: 'name',
  picture:
      'https://economipedia.com/wp-content/uploads/test-de-estr%C3%A9s.png',
  description: 'description',
  types: ['types', 'example'],
);

const pokedexViewModelList = [
  pokedexViewModelComplete,
  pokedexViewModelCompleteTwoTags,
  pokedexViewModelTypesEmpty,
];
