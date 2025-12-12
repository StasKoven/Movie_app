import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/movie_local_data_source.dart';
import '../datasources/movie_remote_data_source.dart';
import '../models/movie_detail_model.dart';
import '../models/movie_list_response.dart';
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

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
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
    if (await networkInfo.isConnected) {
      try {
        final result = await getFromRemote();
        await localDataSource.cacheMovieList(cacheKey, result);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
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
}
