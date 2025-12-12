import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/movie_detail_model.dart';
import '../../data/repositories/movie_repository_impl.dart';

@lazySingleton
class GetMovieDetails implements UseCase<MovieDetailModel, int> {
  final MovieRepository repository;

  GetMovieDetails(this.repository);

  @override
  Future<Either<Failure, MovieDetailModel>> call(int movieId) async {
    return await repository.getMovieDetails(movieId);
  }
}
