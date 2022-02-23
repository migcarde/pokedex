part of 'pokedex_cubit.dart';

abstract class PokedexState extends Equatable {
  const PokedexState();

  @override
  List<Object> get props => [];
}

class PokedexInitial extends PokedexState {}

class PokedexLoading extends PokedexState {}

class PokedexData extends PokedexState {
  final BasePaginationViewModel<PokedexViewModel> data;

  const PokedexData({required this.data});
}

class PokedexError extends PokedexState {
  final String message;

  const PokedexError({required this.message});
}
