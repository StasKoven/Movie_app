import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/add_favorite.dart';
import '../../domain/usecases/get_all_favorites.dart';
import '../../domain/usecases/remove_favorite.dart' as usecases;
import 'favorites_event.dart';
import 'favorites_state.dart';

@injectable
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetAllFavorites getAllFavorites;
  final AddFavorite addFavorite;
  final usecases.RemoveFavorite removeFavorite;

  FavoritesBloc({
    required this.getAllFavorites,
    required this.addFavorite,
    required this.removeFavorite,
  }) : super(const FavoritesState()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<RemoveFavorite>(_onRemoveFavorite);
    on<ClearFavorites>(_onClearFavorites);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(state.copyWith(status: FavoritesStatus.loading));

    final result = await getAllFavorites(const NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        status: FavoritesStatus.failure,
        errorMessage: failure.message,
      )),
      (favorites) => emit(state.copyWith(
        status: FavoritesStatus.success,
        favorites: favorites,
      )),
    );
  }

  Future<void> _onRemoveFavorite(
    RemoveFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    await removeFavorite(event.movieId);
    
    // Reload favorites
    add(LoadFavorites());
  }

  Future<void> _onClearFavorites(
    ClearFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    // Remove all favorites one by one
    for (final favorite in state.favorites) {
      await removeFavorite(favorite.id);
    }
    
    // Reload favorites
    add(LoadFavorites());
  }
}
