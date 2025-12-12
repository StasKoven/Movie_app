import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../datasources/favorites_local_data_source.dart';
import '../models/favorite_movie.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, void>> addFavorite(FavoriteMovie movie);
  Future<Either<Failure, void>> removeFavorite(int movieId);
  Future<Either<Failure, List<FavoriteMovie>>> getAllFavorites();
  Future<Either<Failure, bool>> isFavorite(int movieId);
}

@LazySingleton(as: FavoritesRepository)
class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource localDataSource;

  FavoritesRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> addFavorite(FavoriteMovie movie) async {
    try {
      await localDataSource.addFavorite(movie);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(int movieId) async {
    try {
      await localDataSource.removeFavorite(movieId);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteMovie>>> getAllFavorites() async {
    try {
      final favorites = await localDataSource.getAllFavorites();
      return Right(favorites);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(int movieId) async {
    try {
      final result = await localDataSource.isFavorite(movieId);
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
