import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../shared/widgets/movie_card.dart';
import '../bloc/favorites_bloc.dart';
import '../bloc/favorites_event.dart';
import '../bloc/favorites_state.dart';
import '../../../home/presentation/pages/movie_detail_page.dart';
import '../../../home/presentation/bloc/movie_detail_bloc.dart';
import '../../../home/presentation/bloc/movie_detail_event.dart';
import '../../../home/data/models/movie_model.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FavoritesBloc>()..add(LoadFavorites()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Favorite Movies',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          actions: [
            BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
                if (state.favorites.isEmpty) return const SizedBox();
                return IconButton(
                  icon: const Icon(Icons.delete_sweep),
                  tooltip: 'Clear All',
                  onPressed: () {
                    _showClearAllDialog(context);
                  },
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state.status == FavoritesStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }

            if (state.status == FavoritesStatus.failure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppColors.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.errorMessage ?? 'Failed to load favorites',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state.favorites.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 80,
                      color: AppColors.textSecondary.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'No Favorite Movies Yet',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Start adding movies to your favorites!',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.movie),
                      label: const Text('Browse Movies'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final favorite = state.favorites[index];
                final movie = MovieModel(
                  id: favorite.id,
                  title: favorite.title,
                  posterPath: favorite.posterPath,
                  backdropPath: null,
                  overview: '',
                  voteAverage: favorite.voteAverage,
                  voteCount: 0,
                  releaseDate: favorite.releaseDate,
                  genreIds: const [],
                  adult: false,
                  originalLanguage: '',
                  originalTitle: favorite.title,
                  popularity: 0,
                  video: false,
                );

                return Stack(
                  children: [
                    MovieCard(
                      movie: movie,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) => getIt<MovieDetailBloc>()
                                ..add(LoadMovieDetail(favorite.id)),
                              child: MovieDetailPage(movieId: favorite.id),
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: AppColors.error,
                            size: 20,
                          ),
                          onPressed: () {
                            _showRemoveDialog(context, favorite.id, favorite.title);
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showRemoveDialog(BuildContext context, int movieId, String title) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.backgroundLight,
        title: const Text(
          'Remove from Favorites?',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: Text(
          'Remove "$title" from your favorites?',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<FavoritesBloc>().add(RemoveFavorite(movieId));
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$title removed from favorites'),
                  backgroundColor: AppColors.primary,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _showClearAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.backgroundLight,
        title: const Text(
          'Clear All Favorites?',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: const Text(
          'This will remove all movies from your favorites. This action cannot be undone.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<FavoritesBloc>().add(ClearFavorites());
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All favorites cleared'),
                  backgroundColor: AppColors.primary,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}
