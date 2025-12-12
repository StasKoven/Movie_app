import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/movie_list_response.dart';
import '../../data/repositories/movie_repository_impl.dart';

class DiscoverMoviesParams extends Equatable {
  final int page;
  final String? sortBy;
  final String? withGenres;
  final int? year;
  final double? voteAverageGte;

  const DiscoverMoviesParams({
    this.page = 1,
    this.sortBy,
    this.withGenres,
    this.year,
    this.voteAverageGte,
  });

  @override
  List<Object?> get props => [page, sortBy, withGenres, year, voteAverageGte];
}

@lazySingleton
class DiscoverMovies implements UseCase<MovieListResponse, DiscoverMoviesParams> {
  final MovieRepository repository;

  DiscoverMovies(this.repository);

  @override
  Future<Either<Failure, MovieListResponse>> call(DiscoverMoviesParams params) async {
    return await repository.discoverMovies(
      page: params.page,
      sortBy: params.sortBy,
      withGenres: params.withGenres,
      year: params.year,
      voteAverageGte: params.voteAverageGte,
    );
  }
}
