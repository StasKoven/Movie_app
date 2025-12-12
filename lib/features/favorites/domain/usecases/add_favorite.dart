import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/favorite_movie.dart';
import '../../data/repositories/favorites_repository_impl.dart';

@lazySingleton
class AddFavorite implements UseCase<void, FavoriteMovie> {
  final FavoritesRepository repository;

  AddFavorite(this.repository);

  @override
  Future<Either<Failure, void>> call(FavoriteMovie movie) async {
    return await repository.addFavorite(movie);
  }
}
