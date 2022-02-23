import 'package:equatable/equatable.dart';

class PokemonBusiness extends Equatable {
  final String name;
  final String url;

  const PokemonBusiness({required this.name, required this.url});

  @override
  List<Object?> get props => [name, url];
}
