import 'package:equatable/equatable.dart';

class BasePaginationResponse<T> extends Equatable {
  final int count;
  final List<T> results;
  final String? next;
  final String? previous;

  const BasePaginationResponse({
    required this.count,
    required this.results,
    this.next,
    this.previous,
  });

  factory BasePaginationResponse.fromJson(
          Map<String, dynamic> json, List<T> results) =>
      BasePaginationResponse<T>(
        count: json['count'],
        results: results,
        previous: json['previous'],
        next: json['next'],
      );

  @override
  List<Object?> get props => [count, results, next, previous];
}
