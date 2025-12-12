import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/movie_list_response.dart';
import '../../data/repositories/movie_repository_impl.dart';

@lazySingleton
class GetTopRatedMovies implements UseCase<MovieListResponse, int> {
  final MovieRepository repository;

  GetTopRatedMovies(this.repository);

  @override
  Future<Either<Failure, MovieListResponse>> call(int page) async {
    return await repository.getTopRatedMovies(page);
  }
}
