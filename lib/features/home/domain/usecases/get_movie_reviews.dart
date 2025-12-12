import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/review_model.dart';
import '../../data/repositories/movie_repository_impl.dart';

class GetMovieReviewsParams extends Equatable {
  final int movieId;
  final int page;

  const GetMovieReviewsParams({
    required this.movieId,
    required this.page,
  });

  @override
  List<Object?> get props => [movieId, page];
}

@lazySingleton
class GetMovieReviews implements UseCase<ReviewListResponse, GetMovieReviewsParams> {
  final MovieRepository repository;

  GetMovieReviews(this.repository);

  @override
  Future<Either<Failure, ReviewListResponse>> call(GetMovieReviewsParams params) async {
    return await repository.getMovieReviews(params.movieId, params.page);
  }
}
