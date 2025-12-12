import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/usecases/get_top_rated_movies.dart';
import '../../domain/usecases/get_upcoming_movies.dart';
import 'movie_event.dart';
import 'movie_state.dart';

@injectable
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;
  final GetUpcomingMovies getUpcomingMovies;

  MovieBloc({
    required this.getPopularMovies,
    required this.getTopRatedMovies,
    required this.getUpcomingMovies,
  }) : super(const MovieState()) {
    on<LoadPopularMovies>(_onLoadPopularMovies);
    on<LoadTopRatedMovies>(_onLoadTopRatedMovies);
    on<LoadUpcomingMovies>(_onLoadUpcomingMovies);
    on<LoadMoreMovies>(_onLoadMoreMovies);
    on<RefreshMovies>(_onRefreshMovies);
  }

  Future<void> _onLoadPopularMovies(
    LoadPopularMovies event,
    Emitter<MovieState> emit,
  ) async {
    emit(state.copyWith(status: MovieStatus.loading));

    final result = await getPopularMovies(event.page);

    result.fold(
      (failure) => emit(state.copyWith(
        status: MovieStatus.failure,
        errorMessage: failure.message,
      )),
      (movieList) => emit(state.copyWith(
        status: MovieStatus.success,
        movies: event.page == 1 ? movieList.results : [...state.movies, ...movieList.results],
        currentPage: event.page,
        hasReachedMax: event.page >= movieList.totalPages,
      )),
    );
  }

  Future<void> _onLoadTopRatedMovies(
    LoadTopRatedMovies event,
    Emitter<MovieState> emit,
  ) async {
    emit(state.copyWith(status: MovieStatus.loading));

    final result = await getTopRatedMovies(event.page);

    result.fold(
      (failure) => emit(state.copyWith(
        status: MovieStatus.failure,
        errorMessage: failure.message,
      )),
      (movieList) => emit(state.copyWith(
        status: MovieStatus.success,
        movies: event.page == 1 ? movieList.results : [...state.movies, ...movieList.results],
        currentPage: event.page,
        hasReachedMax: event.page >= movieList.totalPages,
      )),
    );
  }

  Future<void> _onLoadUpcomingMovies(
    LoadUpcomingMovies event,
    Emitter<MovieState> emit,
  ) async {
    emit(state.copyWith(status: MovieStatus.loading));

    final result = await getUpcomingMovies(event.page);

    result.fold(
      (failure) => emit(state.copyWith(
        status: MovieStatus.failure,
        errorMessage: failure.message,
      )),
      (movieList) => emit(state.copyWith(
        status: MovieStatus.success,
        movies: event.page == 1 ? movieList.results : [...state.movies, ...movieList.results],
        currentPage: event.page,
        hasReachedMax: event.page >= movieList.totalPages,
      )),
    );
  }

  Future<void> _onLoadMoreMovies(
    LoadMoreMovies event,
    Emitter<MovieState> emit,
  ) async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(status: MovieStatus.loadingMore));

    final nextPage = state.currentPage + 1;
    final result = await getPopularMovies(nextPage);

    result.fold(
      (failure) => emit(state.copyWith(
        status: MovieStatus.failure,
        errorMessage: failure.message,
      )),
      (movieList) => emit(state.copyWith(
        status: MovieStatus.success,
        movies: [...state.movies, ...movieList.results],
        currentPage: nextPage,
        hasReachedMax: nextPage >= movieList.totalPages,
      )),
    );
  }

  Future<void> _onRefreshMovies(
    RefreshMovies event,
    Emitter<MovieState> emit,
  ) async {
    emit(const MovieState());
    add(const LoadPopularMovies(page: 1));
  }
}
