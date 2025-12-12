import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/favorite_movie.dart';
import '../../data/repositories/favorites_repository_impl.dart';

@lazySingleton
class GetAllFavorites implements UseCase<List<FavoriteMovie>, NoParams> {
  final FavoritesRepository repository;

  GetAllFavorites(this.repository);

  @override
  Future<Either<Failure, List<FavoriteMovie>>> call(NoParams params) async {
    return await repository.getAllFavorites();
  }
}
