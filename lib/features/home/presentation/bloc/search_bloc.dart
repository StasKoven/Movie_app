import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/search_movies.dart';
import 'search_event.dart';
import 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies searchMovies;

  SearchBloc({required this.searchMovies}) : super(const SearchState()) {
    on<SearchMoviesEvent>(_onSearchMovies);
    on<LoadMoreSearchResults>(_onLoadMoreSearchResults);
    on<ClearSearch>(_onClearSearch);
  }

  Future<void> _onSearchMovies(
    SearchMoviesEvent event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(const SearchState());
      return;
    }

    emit(state.copyWith(
      status: SearchStatus.loading,
      query: event.query,
    ));

    final result = await searchMovies(
      SearchMoviesParams(query: event.query, page: event.page),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: SearchStatus.failure,
        errorMessage: failure.message,
      )),
      (movieList) => emit(state.copyWith(
        status: SearchStatus.success,
        movies: event.page == 1 
            ? movieList.results 
            : [...state.movies, ...movieList.results],
        currentPage: event.page,
        hasReachedMax: event.page >= movieList.totalPages,
      )),
    );
  }

  Future<void> _onLoadMoreSearchResults(
    LoadMoreSearchResults event,
    Emitter<SearchState> emit,
  ) async {
    if (state.hasReachedMax || state.query.isEmpty) return;

    emit(state.copyWith(status: SearchStatus.loadingMore));

    final nextPage = state.currentPage + 1;
    final result = await searchMovies(
      SearchMoviesParams(query: state.query, page: nextPage),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: SearchStatus.failure,
        errorMessage: failure.message,
      )),
      (movieList) => emit(state.copyWith(
        status: SearchStatus.success,
        movies: [...state.movies, ...movieList.results],
        currentPage: nextPage,
        hasReachedMax: nextPage >= movieList.totalPages,
      )),
    );
  }

  Future<void> _onClearSearch(
    ClearSearch event,
    Emitter<SearchState> emit,
  ) async {
    emit(const SearchState());
  }
}
