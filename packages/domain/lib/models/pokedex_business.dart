import 'package:equatable/equatable.dart';

class PokedexBusiness extends Equatable {
  final String name;
  final String picture;
  final String description;
  final List<String> types;

  const PokedexBusiness({
    required this.name,
    required this.picture,
    required this.description,
    required this.types,
  });

  @override
  List<Object?> get props => [name, picture, description, types];
}
