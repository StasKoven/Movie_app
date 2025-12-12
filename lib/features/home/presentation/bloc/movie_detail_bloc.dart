import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../favorites/data/models/favorite_movie.dart';
import '../../../favorites/domain/usecases/add_favorite.dart';
import '../../../favorites/domain/usecases/remove_favorite.dart';
import '../../domain/usecases/get_movie_details.dart';
import '../../domain/usecases/get_movie_reviews.dart';
import '../../domain/usecases/get_movie_videos.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

@injectable
class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetails getMovieDetails;
  final GetMovieVideos getMovieVideos;
  final GetMovieReviews getMovieReviews;
  final AddFavorite addFavorite;
  final RemoveFavorite removeFavorite;

  MovieDetailBloc({
    required this.getMovieDetails,
    required this.getMovieVideos,
    required this.getMovieReviews,
    required this.addFavorite,
    required this.removeFavorite,
  }) : super(const MovieDetailState()) {
    on<LoadMovieDetail>(_onLoadMovieDetail);
    on<LoadMovieVideos>(_onLoadMovieVideos);
    on<LoadMovieReviews>(_onLoadMovieReviews);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadMovieDetail(
    LoadMovieDetail event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(state.copyWith(status: MovieDetailStatus.loading));

    final result = await getMovieDetails(event.movieId);

    result.fold(
      (failure) => emit(state.copyWith(
        status: MovieDetailStatus.failure,
        errorMessage: failure.message,
      )),
      (movie) {
        emit(state.copyWith(
          status: MovieDetailStatus.success,
          movie: movie,
        ));
        
        // Load videos and reviews automatically
        add(LoadMovieVideos(event.movieId));
        add(LoadMovieReviews(event.movieId));
      },
    );
  }

  Future<void> _onLoadMovieVideos(
    LoadMovieVideos event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await getMovieVideos(event.movieId);

    result.fold(
      (failure) => null,
      (videoList) => emit(state.copyWith(videos: videoList.results)),
    );
  }

  Future<void> _onLoadMovieReviews(
    LoadMovieReviews event,
    Emitter<MovieDetailState> emit,
  ) async {
    final result = await getMovieReviews(
      GetMovieReviewsParams(movieId: event.movieId, page: event.page),
    );

    result.fold(
      (failure) => null,
      (reviewList) => emit(state.copyWith(reviews: reviewList.results)),
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<MovieDetailState> emit,
  ) async {
    if (state.movie == null) return;

    final movie = state.movie!;
    
    if (state.isFavorite) {
      await removeFavorite(movie.id);
      emit(state.copyWith(isFavorite: false));
    } else {
      final favoriteMovie = FavoriteMovie(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        voteAverage: movie.voteAverage,
        releaseDate: movie.releaseDate,
        addedAt: DateTime.now(),
      );
      await addFavorite(favoriteMovie);
      emit(state.copyWith(isFavorite: true));
    }
  }
}
