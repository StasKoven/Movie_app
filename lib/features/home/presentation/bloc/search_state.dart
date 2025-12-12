import 'package:equatable/equatable.dart';
import '../../data/models/movie_model.dart';

enum SearchStatus { initial, loading, success, failure, loadingMore }

class SearchState extends Equatable {
  final SearchStatus status;
  final List<MovieModel> movies;
  final String? errorMessage;
  final String query;
  final int currentPage;
  final bool hasReachedMax;

  const SearchState({
    this.status = SearchStatus.initial,
    this.movies = const [],
    this.errorMessage,
    this.query = '',
    this.currentPage = 1,
    this.hasReachedMax = false,
  });

  SearchState copyWith({
    SearchStatus? status,
    List<MovieModel>? movies,
    String? errorMessage,
    String? query,
    int? currentPage,
    bool? hasReachedMax,
  }) {
    return SearchState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      errorMessage: errorMessage,
      query: query ?? this.query,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        status,
        movies,
        errorMessage,
        query,
        currentPage,
        hasReachedMax,
      ];
}
