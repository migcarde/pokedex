import 'package:data/models/base_pagination_response.dart';
import 'package:equatable/equatable.dart';

class BasePaginationBusiness<T> extends Equatable {
  final int count;
  final List<T> results;
  final String? next;
  final String? previous;

  const BasePaginationBusiness({
    required this.count,
    required this.results,
    this.next,
    this.previous,
  });

  factory BasePaginationBusiness.fromJson(
          Map<String, dynamic> json, List<T> results) =>
      BasePaginationBusiness<T>(
        count: json['count'],
        results: results,
        previous: json['previous'],
        next: json['next'],
      );

  @override
  List<Object?> get props => [count, results, next, previous];
}

extension BasePaginationBusinessExtension on BasePaginationResponse {
  BasePaginationBusiness<T> toDomain<T>(List<T> results) =>
      BasePaginationBusiness<T>(
        count: count,
        results: results,
        next: next,
        previous: previous,
      );
}
