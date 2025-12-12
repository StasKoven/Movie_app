import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/movie_list_response.dart';
import '../../data/repositories/movie_repository_impl.dart';

class SearchMoviesParams extends Equatable {
  final String query;
  final int page;

  const SearchMoviesParams({
    required this.query,
    required this.page,
  });

  @override
  List<Object?> get props => [query, page];
}

@lazySingleton
class SearchMovies implements UseCase<MovieListResponse, SearchMoviesParams> {
  final MovieRepository repository;

  SearchMovies(this.repository);

  @override
  Future<Either<Failure, MovieListResponse>> call(SearchMoviesParams params) async {
    return await repository.searchMovies(params.query, params.page);
  }
}
