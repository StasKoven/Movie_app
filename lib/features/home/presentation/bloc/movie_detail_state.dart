import 'package:equatable/equatable.dart';
import '../../data/models/movie_detail_model.dart';
import '../../data/models/review_model.dart';
import '../../data/models/video_model.dart';

enum MovieDetailStatus { initial, loading, success, failure }

class MovieDetailState extends Equatable {
  final MovieDetailStatus status;
  final MovieDetailModel? movie;
  final List<VideoModel> videos;
  final List<ReviewModel> reviews;
  final bool isFavorite;
  final String? errorMessage;

  const MovieDetailState({
    this.status = MovieDetailStatus.initial,
    this.movie,
    this.videos = const [],
    this.reviews = const [],
    this.isFavorite = false,
    this.errorMessage,
  });

  MovieDetailState copyWith({
    MovieDetailStatus? status,
    MovieDetailModel? movie,
    List<VideoModel>? videos,
    List<ReviewModel>? reviews,
    bool? isFavorite,
    String? errorMessage,
  }) {
    return MovieDetailState(
      status: status ?? this.status,
      movie: movie ?? this.movie,
      videos: videos ?? this.videos,
      reviews: reviews ?? this.reviews,
      isFavorite: isFavorite ?? this.isFavorite,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        movie,
        videos,
        reviews,
        isFavorite,
        errorMessage,
      ];
}
