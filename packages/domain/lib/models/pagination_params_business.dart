import 'package:equatable/equatable.dart';

class PaginationParamsBusiness extends Equatable {
  final int offset;
  final int limit;

  const PaginationParamsBusiness({required this.offset, required this.limit});

  @override
  List<Object?> get props => [offset, limit];
}
