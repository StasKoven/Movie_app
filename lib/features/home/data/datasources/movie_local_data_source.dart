import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import '../models/movie_detail_model.dart';
import '../models/movie_list_response.dart';

abstract class MovieLocalDataSource {
  Future<void> cacheMovieList(String key, MovieListResponse movieList);
  Future<MovieListResponse?> getCachedMovieList(String key);
  Future<void> cacheMovieDetail(int movieId, MovieDetailModel movie);
  Future<MovieDetailModel?> getCachedMovieDetail(int movieId);
  Future<void> clearCache();
}

@LazySingleton(as: MovieLocalDataSource)
class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  static const String movieListBox = 'movie_list_cache';
  static const String movieDetailBox = 'movie_detail_cache';

  @override
  Future<void> cacheMovieList(String key, MovieListResponse movieList) async {
    try {
      final box = await Hive.openBox<Map>(movieListBox);
      await box.put(key, movieList.toJson());
    } catch (e) {
      // On web, cache might not work properly - just ignore
    }
  }

  @override
  Future<MovieListResponse?> getCachedMovieList(String key) async {
    try {
      final box = await Hive.openBox<Map>(movieListBox);
      final cachedData = box.get(key);
      if (cachedData == null) return null;
      
      return MovieListResponse.fromJson(Map<String, dynamic>.from(cachedData));
    } catch (e) {
      // On web, cache might not work properly - just return null
      return null;
    }
  }

  @override
  Future<void> cacheMovieDetail(int movieId, MovieDetailModel movie) async {
    try {
      final box = await Hive.openBox<Map>(movieDetailBox);
      await box.put(movieId, movie.toJson());
    } catch (e) {
      // On web, cache might not work properly - just ignore
    }
  }

  @override
  Future<MovieDetailModel?> getCachedMovieDetail(int movieId) async {
    try {
      final box = await Hive.openBox<Map>(movieDetailBox);
      final cachedData = box.get(movieId);
      if (cachedData == null) return null;
      
      return MovieDetailModel.fromJson(Map<String, dynamic>.from(cachedData));
    } catch (e) {
      // On web, cache might not work properly - just return null
      return null;
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      final listBox = await Hive.openBox<Map>(movieListBox);
      final detailBox = await Hive.openBox<Map>(movieDetailBox);
      await listBox.clear();
      await detailBox.clear();
    } catch (e) {
      // On web, cache might not work properly - just ignore
    }
  }
}
