import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_discovery/core/error/failures.dart';
import 'package:movie_discovery/features/home/data/models/movie_list_response.dart';
import 'package:movie_discovery/features/home/data/models/movie_model.dart';
import 'package:movie_discovery/features/home/domain/usecases/get_popular_movies.dart';
import 'package:movie_discovery/features/home/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_discovery/features/home/domain/usecases/get_upcoming_movies.dart';
import 'package:movie_discovery/features/home/presentation/bloc/movie_bloc.dart';
import 'package:movie_discovery/features/home/presentation/bloc/movie_event.dart';
import 'package:movie_discovery/features/home/presentation/bloc/movie_state.dart';

class MockGetPopularMovies extends Mock implements GetPopularMovies {}
class MockGetTopRatedMovies extends Mock implements GetTopRatedMovies {}
class MockGetUpcomingMovies extends Mock implements GetUpcomingMovies {}

void main() {
  late MovieBloc bloc;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MockGetUpcomingMovies mockGetUpcomingMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetUpcomingMovies = MockGetUpcomingMovies();
    bloc = MovieBloc(
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
      getUpcomingMovies: mockGetUpcomingMovies,
    );
  });

  tearDown(() {
    bloc.close();
  });

  final tMovieList = MovieListResponse(
    page: 1,
    results: [
      const MovieModel(
        id: 1,
        title: 'Test Movie',
        posterPath: '/test.jpg',
        backdropPath: '/backdrop.jpg',
        overview: 'Test overview',
        voteAverage: 8.5,
        voteCount: 1000,
        releaseDate: '2024-01-01',
        genreIds: [28, 12],
        adult: false,
        originalLanguage: 'en',
        originalTitle: 'Test Movie',
        popularity: 100.0,
        video: false,
      ),
    ],
    totalPages: 10,
    totalResults: 200,
  );

  group('LoadPopularMovies', () {
    blocTest<MovieBloc, MovieState>(
      'emits [loading, success] when data is loaded successfully',
      build: () {
        when(() => mockGetPopularMovies(1))
            .thenAnswer((_) async => Right(tMovieList));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadPopularMovies(page: 1)),
      expect: () => [
        const MovieState(status: MovieStatus.loading),
        MovieState(
          status: MovieStatus.success,
          movies: tMovieList.results,
          currentPage: 1,
          hasReachedMax: false,
        ),
      ],
      verify: (_) {
        verify(() => mockGetPopularMovies(1)).called(1);
      },
    );

    blocTest<MovieBloc, MovieState>(
      'emits [loading, failure] when loading fails',
      build: () {
        when(() => mockGetPopularMovies(1))
            .thenAnswer((_) async => const Left(ServerFailure('Server error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadPopularMovies(page: 1)),
      expect: () => [
        const MovieState(status: MovieStatus.loading),
        const MovieState(
          status: MovieStatus.failure,
          errorMessage: 'Server error',
        ),
      ],
    );
  });
}
