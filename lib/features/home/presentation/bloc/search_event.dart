import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchMoviesEvent extends SearchEvent {
  final String query;
  final int page;

  const SearchMoviesEvent({
    required this.query,
    this.page = 1,
  });

  @override
  List<Object?> get props => [query, page];
}

class LoadMoreSearchResults extends SearchEvent {
  const LoadMoreSearchResults();
}

class ClearSearch extends SearchEvent {
  const ClearSearch();
}
