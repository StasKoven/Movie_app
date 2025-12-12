import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_discovery/core/error/failures.dart';
import 'package:movie_discovery/features/home/data/models/movie_list_response.dart';
import 'package:movie_discovery/features/home/data/models/movie_model.dart';
import 'package:movie_discovery/features/home/data/repositories/movie_repository_impl.dart';
import 'package:movie_discovery/features/home/domain/usecases/get_popular_movies.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetPopularMovies useCase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    useCase = GetPopularMovies(mockRepository);
  });

  const tPage = 1;
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

  test('should get popular movies from repository', () async {
    // arrange
    when(() => mockRepository.getPopularMovies(tPage))
        .thenAnswer((_) async => Right(tMovieList));

    // act
    final result = await useCase(tPage);

    // assert
    expect(result, Right(tMovieList));
    verify(() => mockRepository.getPopularMovies(tPage));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when repository fails', () async {
    // arrange
    const tFailure = ServerFailure('Server error');
    when(() => mockRepository.getPopularMovies(tPage))
        .thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await useCase(tPage);

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockRepository.getPopularMovies(tPage));
    verifyNoMoreInteractions(mockRepository);
  });
}
