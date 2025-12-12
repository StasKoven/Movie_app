import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadMovieDetail extends MovieDetailEvent {
  final int movieId;

  const LoadMovieDetail(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

class LoadMovieVideos extends MovieDetailEvent {
  final int movieId;

  const LoadMovieVideos(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

class LoadMovieReviews extends MovieDetailEvent {
  final int movieId;
  final int page;

  const LoadMovieReviews(this.movieId, {this.page = 1});

  @override
  List<Object?> get props => [movieId, page];
}

class ToggleFavorite extends MovieDetailEvent {
  const ToggleFavorite();
}
