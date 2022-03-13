import 'package:domain/models/base_pagination_business.dart';
import 'package:equatable/equatable.dart';

class BasePaginationViewModel<T> extends Equatable {
  final int count;
  final List<T> results;
  final String? next;
  final String? previous;

  const BasePaginationViewModel({
    required this.count,
    required this.results,
    this.next,
    this.previous,
  });

  factory BasePaginationViewModel.fromJson(
          Map<String, dynamic> json, List<T> results) =>
      BasePaginationViewModel<T>(
        count: json['count'],
        results: results,
        previous: json['previous'],
        next: json['next'],
      );

  @override
  List<Object?> get props => [count, results, next, previous];
}

extension BasePaginationViewModelExtensions on BasePaginationBusiness {
  BasePaginationViewModel<T> toViewModel<T>(List<T> results) =>
      BasePaginationViewModel(
        count: count,
        results: results,
        next: next,
        previous: previous,
      );
}
