import 'package:equatable/equatable.dart';
import '../../data/models/movie_model.dart';

enum MovieStatus { initial, loading, success, failure, loadingMore }

class MovieState extends Equatable {
  final MovieStatus status;
  final List<MovieModel> movies;
  final String? errorMessage;
  final int currentPage;
  final bool hasReachedMax;

  const MovieState({
    this.status = MovieStatus.initial,
    this.movies = const [],
    this.errorMessage,
    this.currentPage = 1,
    this.hasReachedMax = false,
  });

  MovieState copyWith({
    MovieStatus? status,
    List<MovieModel>? movies,
    String? errorMessage,
    int? currentPage,
    bool? hasReachedMax,
  }) {
    return MovieState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      errorMessage: errorMessage,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        status,
        movies,
        errorMessage,
        currentPage,
        hasReachedMax,
      ];
}
