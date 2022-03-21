import 'package:equatable/equatable.dart';

class PokedexLocalDatabaseParams extends Equatable {
  final int limit;
  final int offset;

  const PokedexLocalDatabaseParams({required this.limit, required this.offset});

  @override
  List<Object?> get props => [limit, offset];
}
