import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_discovery/core/error/exceptions.dart';
import 'package:movie_discovery/core/error/failures.dart';
import 'package:movie_discovery/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:movie_discovery/features/favorites/data/models/favorite_movie.dart';
import 'package:movie_discovery/features/favorites/data/repositories/favorites_repository_impl.dart';

class MockFavoritesLocalDataSource extends Mock
    implements FavoritesLocalDataSource {}

void main() {
  late FavoritesRepositoryImpl repository;
  late MockFavoritesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockFavoritesLocalDataSource();
    repository = FavoritesRepositoryImpl(localDataSource: mockLocalDataSource);
  });

  final tFavoriteMovie = FavoriteMovie(
    id: 1,
    title: 'Test Movie',
    posterPath: '/test.jpg',
    voteAverage: 8.5,
    releaseDate: '2024-01-01',
    addedAt: DateTime(2024, 1, 1),
  );

  final tFavoriteMovies = [
    tFavoriteMovie,
    FavoriteMovie(
      id: 2,
      title: 'Test Movie 2',
      posterPath: '/test2.jpg',
      voteAverage: 7.5,
      releaseDate: '2024-02-01',
      addedAt: DateTime(2024, 2, 1),
    ),
  ];

  group('addFavorite', () {
    test('should add favorite movie successfully', () async {
      // arrange
      when(() => mockLocalDataSource.addFavorite(tFavoriteMovie))
          .thenAnswer((_) async {});

      // act
      final result = await repository.addFavorite(tFavoriteMovie);

      // assert
      expect(result, equals(const Right(null)));
      verify(() => mockLocalDataSource.addFavorite(tFavoriteMovie)).called(1);
    });

    test('should return CacheFailure when adding favorite fails', () async {
      // arrange
      when(() => mockLocalDataSource.addFavorite(tFavoriteMovie))
          .thenThrow(CacheException('Failed to add favorite'));

      // act
      final result = await repository.addFavorite(tFavoriteMovie);

      // assert
      expect(
        result,
        equals(Left(CacheFailure('Failed to add favorite'))),
      );
    });
  });

  group('removeFavorite', () {
    const tMovieId = 1;

    test('should remove favorite movie successfully', () async {
      // arrange
      when(() => mockLocalDataSource.removeFavorite(tMovieId))
          .thenAnswer((_) async {});

      // act
      final result = await repository.removeFavorite(tMovieId);

      // assert
      expect(result, equals(const Right(null)));
      verify(() => mockLocalDataSource.removeFavorite(tMovieId)).called(1);
    });

    test('should return CacheFailure when removing favorite fails', () async {
      // arrange
      when(() => mockLocalDataSource.removeFavorite(tMovieId))
          .thenThrow(CacheException('Failed to remove favorite'));

      // act
      final result = await repository.removeFavorite(tMovieId);

      // assert
      expect(
        result,
        equals(Left(CacheFailure('Failed to remove favorite'))),
      );
    });
  });

  group('getAllFavorites', () {
    test('should return list of favorite movies', () async {
      // arrange
      when(() => mockLocalDataSource.getAllFavorites())
          .thenAnswer((_) async => tFavoriteMovies);

      // act
      final result = await repository.getAllFavorites();

      // assert
      expect(result, equals(Right(tFavoriteMovies)));
      verify(() => mockLocalDataSource.getAllFavorites()).called(1);
    });

    test('should return empty list when no favorites exist', () async {
      // arrange
      when(() => mockLocalDataSource.getAllFavorites())
          .thenAnswer((_) async => []);

      // act
      final result = await repository.getAllFavorites();

      // assert
      expect(result.isRight(), true);
    });

    test('should return CacheFailure when getting favorites fails', () async {
      // arrange
      when(() => mockLocalDataSource.getAllFavorites())
          .thenThrow(CacheException('Failed to get favorites'));

      // act
      final result = await repository.getAllFavorites();

      // assert
      expect(
        result,
        equals(Left(CacheFailure('Failed to get favorites'))),
      );
    });
  });

  group('isFavorite', () {
    const tMovieId = 1;

    test('should return true when movie is favorite', () async {
      // arrange
      when(() => mockLocalDataSource.isFavorite(tMovieId))
          .thenAnswer((_) async => true);

      // act
      final result = await repository.isFavorite(tMovieId);

      // assert
      expect(result, equals(const Right(true)));
      verify(() => mockLocalDataSource.isFavorite(tMovieId)).called(1);
    });

    test('should return false when movie is not favorite', () async {
      // arrange
      when(() => mockLocalDataSource.isFavorite(tMovieId))
          .thenAnswer((_) async => false);

      // act
      final result = await repository.isFavorite(tMovieId);

      // assert
      expect(result, equals(const Right(false)));
    });

    test('should return CacheFailure when checking favorite fails', () async {
      // arrange
      when(() => mockLocalDataSource.isFavorite(tMovieId))
          .thenThrow(CacheException('Failed to check favorite'));

      // act
      final result = await repository.isFavorite(tMovieId);

      // assert
      expect(
        result,
        equals(Left(CacheFailure('Failed to check favorite'))),
      );
    });
  });
}
