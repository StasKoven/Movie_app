import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart' as drift;
import 'package:injectable/injectable.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/movie_local_data_source.dart';
import '../datasources/movie_remote_data_source.dart';
import '../models/movie_detail_model.dart';
import '../models/movie_list_response.dart';
import '../models/movie_model.dart';
import '../models/review_model.dart';
import '../models/video_model.dart';

abstract class MovieRepository {
  Future<Either<Failure, MovieListResponse>> getPopularMovies(int page);
  Future<Either<Failure, MovieListResponse>> getTopRatedMovies(int page);
  Future<Either<Failure, MovieListResponse>> getUpcomingMovies(int page);
  Future<Either<Failure, MovieListResponse>> getNowPlayingMovies(int page);
  Future<Either<Failure, MovieListResponse>> searchMovies(String query, int page);
  Future<Either<Failure, MovieDetailModel>> getMovieDetails(int movieId);
  Future<Either<Failure, VideoListResponse>> getMovieVideos(int movieId);
  Future<Either<Failure, ReviewListResponse>> getMovieReviews(int movieId, int page);
  Future<Either<Failure, MovieListResponse>> discoverMovies({
    int page = 1,
    String? sortBy,
    String? withGenres,
    int? year,
    double? voteAverageGte,
  });
}

@LazySingleton(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final AppDatabase database;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.database,
  });

  @override
  Future<Either<Failure, MovieListResponse>> getPopularMovies(int page) async {
    return _getMovieList(
      'popular_$page',
      () => remoteDataSource.getPopularMovies(page),
    );
  }

  @override
  Future<Either<Failure, MovieListResponse>> getTopRatedMovies(int page) async {
    return _getMovieList(
      'top_rated_$page',
      () => remoteDataSource.getTopRatedMovies(page),
    );
  }

  @override
  Future<Either<Failure, MovieListResponse>> getUpcomingMovies(int page) async {
    return _getMovieList(
      'upcoming_$page',
      () => remoteDataSource.getUpcomingMovies(page),
    );
  }

  @override
  Future<Either<Failure, MovieListResponse>> getNowPlayingMovies(int page) async {
    return _getMovieList(
      'now_playing_$page',
      () => remoteDataSource.getNowPlayingMovies(page),
    );
  }

  @override
  Future<Either<Failure, MovieListResponse>> searchMovies(String query, int page) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.searchMovies(query, page);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, MovieDetailModel>> getMovieDetails(int movieId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getMovieDetails(movieId);
        await localDataSource.cacheMovieDetail(movieId, result);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final cachedResult = await localDataSource.getCachedMovieDetail(movieId);
        if (cachedResult != null) {
          return Right(cachedResult);
        } else {
          return const Left(CacheFailure('No cached data available'));
        }
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, VideoListResponse>> getMovieVideos(int movieId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getMovieVideos(movieId);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, ReviewListResponse>> getMovieReviews(int movieId, int page) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getMovieReviews(movieId, page);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, MovieListResponse>> discoverMovies({
    int page = 1,
    String? sortBy,
    String? withGenres,
    int? year,
    double? voteAverageGte,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.discoverMovies(
          page: page,
          sortBy: sortBy,
          withGenres: withGenres,
          year: year,
          voteAverageGte: voteAverageGte,
        );
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  Future<Either<Failure, MovieListResponse>> _getMovieList(
    String cacheKey,
    Future<MovieListResponse> Function() getFromRemote,
  ) async {
    final category = cacheKey.split('_').first;
    
    if (await networkInfo.isConnected) {
      try {
        final result = await getFromRemote();
        
        // Cache in Hive (existing cache)
        await localDataSource.cacheMovieList(cacheKey, result);
        
        // Cache in SQLite database
        await _cacheMoviesInDatabase(result.results, category);
        
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      // Try SQLite cache first
      try {
        final cachedMovies = await database.getCachedMoviesByCategory(category);
        if (cachedMovies.isNotEmpty) {
          final movieList = _convertCachedMoviesToModels(cachedMovies);
          return Right(MovieListResponse(
            page: 1,
            results: movieList,
            totalPages: 1,
            totalResults: movieList.length,
          ));
        }
      } catch (e) {
        // Fall through to Hive cache
      }
      
      // Fallback to Hive cache
      try {
        final cachedResult = await localDataSource.getCachedMovieList(cacheKey);
        if (cachedResult != null) {
          return Right(cachedResult);
        } else {
          return const Left(CacheFailure('No cached data available'));
        }
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }
  
  Future<void> _cacheMoviesInDatabase(List<MovieModel> movies, String category) async {
    final companions = movies.map((movie) {
      return CachedMoviesCompanion(
        id: drift.Value(movie.id),
        title: drift.Value(movie.title),
        overview: drift.Value(movie.overview),
        posterPath: drift.Value(movie.posterPath),
        backdropPath: drift.Value(movie.backdropPath),
        voteAverage: drift.Value(movie.voteAverage),
        voteCount: drift.Value(movie.voteCount),
        releaseDate: drift.Value(movie.releaseDate),
        adult: drift.Value(movie.adult),
        originalLanguage: drift.Value(movie.originalLanguage),
        popularity: drift.Value(movie.popularity),
        genreIds: drift.Value(jsonEncode(movie.genreIds)),
        category: drift.Value(category),
        cachedAt: drift.Value(DateTime.now()),
      );
    }).toList();
    
    await database.cacheMovies(companions);
  }
  
  List<MovieModel> _convertCachedMoviesToModels(List<CachedMovy> cachedMovies) {
    return cachedMovies.map((cached) {
      return MovieModel(
        id: cached.id,
        title: cached.title,
        overview: cached.overview,
        posterPath: cached.posterPath,
        backdropPath: cached.backdropPath,
        voteAverage: cached.voteAverage,
        voteCount: cached.voteCount,
        releaseDate: cached.releaseDate,
        adult: cached.adult,
        originalLanguage: cached.originalLanguage,
        originalTitle: cached.title, // Using title as originalTitle
        popularity: cached.popularity,
        genreIds: List<int>.from(jsonDecode(cached.genreIds)),
        video: false, // Default value
      );
    }).toList();
  }
}
