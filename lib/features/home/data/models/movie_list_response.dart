import 'package:equatable/equatable.dart';
import 'movie_model.dart';

class MovieListResponse extends Equatable {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  const MovieListResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieListResponse.fromJson(Map<String, dynamic> json) {
    return MovieListResponse(
      page: json['page'] ?? 1,
      results: (json['results'] as List?)
              ?.map((movie) => MovieModel.fromJson(movie))
              .toList() ??
          [],
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results.map((movie) => movie.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }

  @override
  List<Object?> get props => [page, results, totalPages, totalResults];
}
