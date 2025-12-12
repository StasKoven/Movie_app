import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/repositories/favorites_repository_impl.dart';

@lazySingleton
class RemoveFavorite implements UseCase<void, int> {
  final FavoritesRepository repository;

  RemoveFavorite(this.repository);

  @override
  Future<Either<Failure, void>> call(int movieId) async {
    return await repository.removeFavorite(movieId);
  }
}
