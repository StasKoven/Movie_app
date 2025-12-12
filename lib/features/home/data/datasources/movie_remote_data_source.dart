import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';
import '../models/movie_detail_model.dart';
import '../models/movie_list_response.dart';
import '../models/review_model.dart';
import '../models/video_model.dart';

abstract class MovieRemoteDataSource {
  Future<MovieListResponse> getPopularMovies(int page);
  Future<MovieListResponse> getTopRatedMovies(int page);
  Future<MovieListResponse> getUpcomingMovies(int page);
  Future<MovieListResponse> getNowPlayingMovies(int page);
  Future<MovieListResponse> searchMovies(String query, int page);
  Future<MovieDetailModel> getMovieDetails(int movieId);
  Future<VideoListResponse> getMovieVideos(int movieId);
  Future<ReviewListResponse> getMovieReviews(int movieId, int page);
  Future<MovieListResponse> discoverMovies({
    int page = 1,
    String? sortBy,
    String? withGenres,
    int? year,
    double? voteAverageGte,
  });
}

@LazySingleton(as: MovieRemoteDataSource)
class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio dio;

  MovieRemoteDataSourceImpl({required this.dio});

  @override
  Future<MovieListResponse> getPopularMovies(int page) async {
    try {
      final response = await dio.get(
        '/movie/popular',
        queryParameters: {'page': page},
      );
      return MovieListResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['status_message'] ?? 'Server error',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<MovieListResponse> getTopRatedMovies(int page) async {
    try {
      final response = await dio.get(
        '/movie/top_rated',
        queryParameters: {'page': page},
      );
      return MovieListResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['status_message'] ?? 'Server error',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<MovieListResponse> getUpcomingMovies(int page) async {
    try {
      final response = await dio.get(
        '/movie/upcoming',
        queryParameters: {'page': page},
      );
      return MovieListResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['status_message'] ?? 'Server error',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<MovieListResponse> getNowPlayingMovies(int page) async {
    try {
      final response = await dio.get(
        '/movie/now_playing',
        queryParameters: {'page': page},
      );
      return MovieListResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['status_message'] ?? 'Server error',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<MovieListResponse> searchMovies(String query, int page) async {
    try {
      final response = await dio.get(
        '/search/movie',
        queryParameters: {
          'query': query,
          'page': page,
        },
      );
      return MovieListResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['status_message'] ?? 'Server error',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetails(int movieId) async {
    try {
      final response = await dio.get('/movie/$movieId');
      return MovieDetailModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['status_message'] ?? 'Server error',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<VideoListResponse> getMovieVideos(int movieId) async {
    try {
      final response = await dio.get('/movie/$movieId/videos');
      return VideoListResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['status_message'] ?? 'Server error',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<ReviewListResponse> getMovieReviews(int movieId, int page) async {
    try {
      final response = await dio.get(
        '/movie/$movieId/reviews',
        queryParameters: {'page': page},
      );
      return ReviewListResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['status_message'] ?? 'Server error',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<MovieListResponse> discoverMovies({
    int page = 1,
    String? sortBy,
    String? withGenres,
    int? year,
    double? voteAverageGte,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        if (sortBy != null) 'sort_by': sortBy,
        if (withGenres != null) 'with_genres': withGenres,
        if (year != null) 'year': year,
        if (voteAverageGte != null) 'vote_average.gte': voteAverageGte,
      };

      final response = await dio.get(
        '/discover/movie',
        queryParameters: queryParams,
      );
      return MovieListResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['status_message'] ?? 'Server error',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
