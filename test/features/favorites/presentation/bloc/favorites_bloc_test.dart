import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_discovery/core/error/failures.dart';
import 'package:movie_discovery/core/usecase/usecase.dart';
import 'package:movie_discovery/features/favorites/data/models/favorite_movie.dart';
import 'package:movie_discovery/features/favorites/domain/usecases/add_favorite.dart';
import 'package:movie_discovery/features/favorites/domain/usecases/get_all_favorites.dart';
import 'package:movie_discovery/features/favorites/domain/usecases/remove_favorite.dart'
    as usecases;
import 'package:movie_discovery/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:movie_discovery/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:movie_discovery/features/favorites/presentation/bloc/favorites_state.dart';

class MockGetAllFavorites extends Mock implements GetAllFavorites {}
class MockAddFavorite extends Mock implements AddFavorite {}
class MockRemoveFavorite extends Mock implements usecases.RemoveFavorite {}

void main() {
  late FavoritesBloc bloc;
  late MockGetAllFavorites mockGetAllFavorites;
  late MockAddFavorite mockAddFavorite;
  late MockRemoveFavorite mockRemoveFavorite;

  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  setUp(() {
    mockGetAllFavorites = MockGetAllFavorites();
    mockAddFavorite = MockAddFavorite();
    mockRemoveFavorite = MockRemoveFavorite();
    bloc = FavoritesBloc(
      getAllFavorites: mockGetAllFavorites,
      addFavorite: mockAddFavorite,
      removeFavorite: mockRemoveFavorite,
    );
  });

  tearDown(() {
    bloc.close();
  });

  final tFavoriteMovies = [
    FavoriteMovie(
      id: 1,
      title: 'Test Movie 1',
      posterPath: '/test1.jpg',
      voteAverage: 8.5,
      releaseDate: '2024-01-01',
      addedAt: DateTime(2024, 1, 1),
    ),
    FavoriteMovie(
      id: 2,
      title: 'Test Movie 2',
      posterPath: '/test2.jpg',
      voteAverage: 7.5,
      releaseDate: '2024-02-01',
      addedAt: DateTime(2024, 2, 1),
    ),
  ];

  group('LoadFavorites', () {
    test('initial state should be FavoritesState with initial status', () {
      expect(bloc.state, equals(const FavoritesState()));
    });

    blocTest<FavoritesBloc, FavoritesState>(
      'emits [loading, success] when loading favorites succeeds',
      build: () {
        when(() => mockGetAllFavorites(any())).thenAnswer(
          (_) async => Right(tFavoriteMovies),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(LoadFavorites()),
      expect: () => [
        const FavoritesState(status: FavoritesStatus.loading),
        FavoritesState(
          status: FavoritesStatus.success,
          favorites: tFavoriteMovies,
        ),
      ],
      verify: (_) {
        verify(() => mockGetAllFavorites(const NoParams())).called(1);
      },
    );

    blocTest<FavoritesBloc, FavoritesState>(
      'emits [loading, failure] when loading favorites fails',
      build: () {
        when(() => mockGetAllFavorites(any())).thenAnswer(
          (_) async => Left(CacheFailure('Failed to load favorites')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(LoadFavorites()),
      expect: () => [
        const FavoritesState(status: FavoritesStatus.loading),
        const FavoritesState(
          status: FavoritesStatus.failure,
          errorMessage: 'Failed to load favorites',
        ),
      ],
    );

    blocTest<FavoritesBloc, FavoritesState>(
      'emits success with empty list when no favorites exist',
      build: () {
        when(() => mockGetAllFavorites(any())).thenAnswer(
          (_) async => const Right([]),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(LoadFavorites()),
      expect: () => [
        const FavoritesState(status: FavoritesStatus.loading),
        const FavoritesState(
          status: FavoritesStatus.success,
          favorites: [],
        ),
      ],
    );
  });

  group('RemoveFavorite', () {
    blocTest<FavoritesBloc, FavoritesState>(
      'removes favorite and reloads list',
      build: () {
        when(() => mockRemoveFavorite(any())).thenAnswer(
          (_) async => const Right(null),
        );
        when(() => mockGetAllFavorites(any())).thenAnswer(
          (_) async => Right([tFavoriteMovies[1]]),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const RemoveFavorite(1)),
      expect: () => [
        const FavoritesState(status: FavoritesStatus.loading),
        FavoritesState(
          status: FavoritesStatus.success,
          favorites: [tFavoriteMovies[1]],
        ),
      ],
      verify: (_) {
        verify(() => mockRemoveFavorite(1)).called(1);
        verify(() => mockGetAllFavorites(const NoParams())).called(1);
      },
    );
  });

  group('ClearFavorites', () {
    blocTest<FavoritesBloc, FavoritesState>(
      'clears all favorites and reloads list',
      build: () {
        when(() => mockRemoveFavorite(any())).thenAnswer(
          (_) async => const Right(null),
        );
        when(() => mockGetAllFavorites(any())).thenAnswer(
          (_) async => const Right([]),
        );
        return bloc;
      },
      seed: () => FavoritesState(
        status: FavoritesStatus.success,
        favorites: tFavoriteMovies,
      ),
      act: (bloc) => bloc.add(ClearFavorites()),
      expect: () => [
        FavoritesState(
          status: FavoritesStatus.loading,
          favorites: tFavoriteMovies,
        ),
        const FavoritesState(
          status: FavoritesStatus.success,
          favorites: [],
        ),
      ],
      verify: (_) {
        verify(() => mockRemoveFavorite(1)).called(1);
        verify(() => mockRemoveFavorite(2)).called(1);
        verify(() => mockGetAllFavorites(const NoParams())).called(1);
      },
    );
  });
}
