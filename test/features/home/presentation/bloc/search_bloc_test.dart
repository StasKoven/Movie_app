import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_discovery/core/error/failures.dart';
import 'package:movie_discovery/features/home/data/models/movie_list_response.dart';
import 'package:movie_discovery/features/home/data/models/movie_model.dart';
import 'package:movie_discovery/features/home/domain/usecases/search_movies.dart';
import 'package:movie_discovery/features/home/presentation/bloc/search_bloc.dart';
import 'package:movie_discovery/features/home/presentation/bloc/search_event.dart';
import 'package:movie_discovery/features/home/presentation/bloc/search_state.dart';

class MockSearchMovies extends Mock implements SearchMovies {}

void main() {
  late SearchBloc bloc;
  late MockSearchMovies mockSearchMovies;

  setUpAll(() {
    registerFallbackValue(const SearchMoviesParams(query: '', page: 1));
  });

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    bloc = SearchBloc(searchMovies: mockSearchMovies);
  });

  tearDown(() {
    bloc.close();
  });

  const tQuery = 'Inception';
  final tMovieList = MovieListResponse(
    page: 1,
    results: [
      const MovieModel(
        id: 1,
        title: 'Inception',
        posterPath: '/inception.jpg',
        backdropPath: '/backdrop.jpg',
        overview: 'A mind-bending thriller',
        voteAverage: 8.8,
        voteCount: 10000,
        releaseDate: '2010-07-16',
        genreIds: [28, 878],
        adult: false,
        originalLanguage: 'en',
        originalTitle: 'Inception',
        popularity: 123.45,
        video: false,
      ),
    ],
    totalPages: 1,
    totalResults: 1,
  );

  group('SearchMoviesEvent', () {
    test('initial state should be SearchState with initial status', () {
      expect(bloc.state, equals(const SearchState()));
    });

    blocTest<SearchBloc, SearchState>(
      'emits [loading, success] when search succeeds',
      build: () {
        when(() => mockSearchMovies(any())).thenAnswer(
          (_) async => Right(tMovieList),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const SearchMoviesEvent(query: tQuery)),
      expect: () => [
        const SearchState(status: SearchStatus.loading, query: tQuery),
        SearchState(
          status: SearchStatus.success,
          movies: tMovieList.results,
          query: tQuery,
          hasReachedMax: true,
        ),
      ],
      verify: (_) {
        verify(() => mockSearchMovies(
          SearchMoviesParams(query: tQuery, page: 1),
        )).called(1);
      },
    );

    blocTest<SearchBloc, SearchState>(
      'emits [loading, failure] when search fails',
      build: () {
        when(() => mockSearchMovies(any())).thenAnswer(
          (_) async => Left(ServerFailure('Search failed')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const SearchMoviesEvent(query: tQuery)),
      expect: () => [
        const SearchState(status: SearchStatus.loading, query: tQuery),
        const SearchState(
          status: SearchStatus.failure,
          errorMessage: 'Search failed',
          query: tQuery,
        ),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'emits success with empty list when no results found',
      build: () {
        when(() => mockSearchMovies(any())).thenAnswer(
          (_) async => Right(MovieListResponse(
            page: 1,
            results: const [],
            totalPages: 0,
            totalResults: 0,
          )),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const SearchMoviesEvent(query: 'NonExistentMovie')),
      expect: () => [
        const SearchState(status: SearchStatus.loading, query: 'NonExistentMovie'),
        const SearchState(
          status: SearchStatus.success,
          movies: [],
          query: 'NonExistentMovie',
          hasReachedMax: true,
        ),
      ],
    );
  });

  group('LoadMoreSearchResults', () {
    final tExistingMovies = [
      const MovieModel(
        id: 1,
        title: 'Movie 1',
        posterPath: '/test1.jpg',
        backdropPath: '/backdrop1.jpg',
        overview: 'Overview 1',
        voteAverage: 7.5,
        voteCount: 1000,
        releaseDate: '2024-01-01',
        genreIds: [28],
        adult: false,
        originalLanguage: 'en',
        originalTitle: 'Movie 1',
        popularity: 100.0,
        video: false,
      ),
    ];

    final tMoreMovies = MovieListResponse(
      page: 2,
      results: [
        const MovieModel(
          id: 2,
          title: 'Movie 2',
          posterPath: '/test2.jpg',
          backdropPath: '/backdrop2.jpg',
          overview: 'Overview 2',
          voteAverage: 8.0,
          voteCount: 2000,
          releaseDate: '2024-02-01',
          genreIds: [28],
          adult: false,
          originalLanguage: 'en',
          originalTitle: 'Movie 2',
          popularity: 150.0,
          video: false,
        ),
      ],
      totalPages: 2,
      totalResults: 2,
    );

    blocTest<SearchBloc, SearchState>(
      'loads more results and appends to existing list',
      build: () {
        when(() => mockSearchMovies(any())).thenAnswer(
          (_) async => Right(tMoreMovies),
        );
        return bloc;
      },
      seed: () => SearchState(
        status: SearchStatus.success,
        movies: tExistingMovies,
        query: tQuery,
        currentPage: 1,
        hasReachedMax: false,
      ),
      act: (bloc) => bloc.add(const LoadMoreSearchResults()),
      expect: () => [
        SearchState(
          status: SearchStatus.loadingMore,
          movies: tExistingMovies,
          query: tQuery,
          currentPage: 1,
          hasReachedMax: false,
        ),
        SearchState(
          status: SearchStatus.success,
          movies: [...tExistingMovies, ...tMoreMovies.results],
          query: tQuery,
          currentPage: 2,
          hasReachedMax: true,
        ),
      ],
    );
  });

  group('ClearSearch', () {
    blocTest<SearchBloc, SearchState>(
      'clears search state',
      build: () => bloc,
      seed: () => SearchState(
        status: SearchStatus.success,
        movies: tMovieList.results,
        query: tQuery,
      ),
      act: (bloc) => bloc.add(const ClearSearch()),
      expect: () => [
        const SearchState(),
      ],
    );
  });
}
