import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object?> get props => [];
}

class LoadPopularMovies extends MovieEvent {
  final int page;

  const LoadPopularMovies({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class LoadTopRatedMovies extends MovieEvent {
  final int page;

  const LoadTopRatedMovies({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class LoadUpcomingMovies extends MovieEvent {
  final int page;

  const LoadUpcomingMovies({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class LoadNowPlayingMovies extends MovieEvent {
  final int page;

  const LoadNowPlayingMovies({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class LoadMoreMovies extends MovieEvent {
  const LoadMoreMovies();
}

class RefreshMovies extends MovieEvent {
  const RefreshMovies();
}
