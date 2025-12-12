import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';
import '../models/favorite_movie.dart';

abstract class FavoritesLocalDataSource {
  Future<void> addFavorite(FavoriteMovie movie);
  Future<void> removeFavorite(int movieId);
  Future<List<FavoriteMovie>> getAllFavorites();
  Future<bool> isFavorite(int movieId);
}

@LazySingleton(as: FavoritesLocalDataSource)
class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  static const String favoritesBox = 'favorites_box';

  @override
  Future<void> addFavorite(FavoriteMovie movie) async {
    try {
      final box = await Hive.openBox<FavoriteMovie>(favoritesBox);
      await box.put(movie.id, movie);
    } catch (e) {
      throw CacheException('Failed to add favorite: ${e.toString()}');
    }
  }

  @override
  Future<void> removeFavorite(int movieId) async {
    try {
      final box = await Hive.openBox<FavoriteMovie>(favoritesBox);
      await box.delete(movieId);
    } catch (e) {
      throw CacheException('Failed to remove favorite: ${e.toString()}');
    }
  }

  @override
  Future<List<FavoriteMovie>> getAllFavorites() async {
    try {
      final box = await Hive.openBox<FavoriteMovie>(favoritesBox);
      return box.values.toList()
        ..sort((a, b) => b.addedAt.compareTo(a.addedAt));
    } catch (e) {
      throw CacheException('Failed to get favorites: ${e.toString()}');
    }
  }

  @override
  Future<bool> isFavorite(int movieId) async {
    try {
      final box = await Hive.openBox<FavoriteMovie>(favoritesBox);
      return box.containsKey(movieId);
    } catch (e) {
      throw CacheException('Failed to check favorite: ${e.toString()}');
    }
  }
}
