import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_discovery/core/error/failures.dart';
import 'package:movie_discovery/features/favorites/data/models/favorite_movie.dart';
import 'package:movie_discovery/features/favorites/domain/usecases/add_favorite.dart';
import 'package:movie_discovery/features/favorites/domain/usecases/remove_favorite.dart';
import 'package:movie_discovery/features/home/data/models/movie_detail_model.dart';
import 'package:movie_discovery/features/home/data/models/video_model.dart';
import 'package:movie_discovery/features/home/data/models/review_model.dart';
import 'package:movie_discovery/features/home/domain/usecases/get_movie_details.dart';
import 'package:movie_discovery/features/home/domain/usecases/get_movie_videos.dart';
import 'package:movie_discovery/features/home/domain/usecases/get_movie_reviews.dart';
import 'package:movie_discovery/features/home/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie_discovery/features/home/presentation/bloc/movie_detail_event.dart';
import 'package:movie_discovery/features/home/presentation/bloc/movie_detail_state.dart';

class MockGetMovieDetails extends Mock implements GetMovieDetails {}
class MockGetMovieVideos extends Mock implements GetMovieVideos {}
class MockGetMovieReviews extends Mock implements GetMovieReviews {}
class MockAddFavorite extends Mock implements AddFavorite {}
class MockRemoveFavorite extends Mock implements RemoveFavorite {}

void main() {
  late MovieDetailBloc bloc;
  late MockGetMovieDetails mockGetMovieDetails;
  late MockGetMovieVideos mockGetMovieVideos;
  late MockGetMovieReviews mockGetMovieReviews;
  late MockAddFavorite mockAddFavorite;
  late MockRemoveFavorite mockRemoveFavorite;

  setUpAll(() {
    registerFallbackValue(FavoriteMovie(
      id: 1,
      title: 'Test',
      voteAverage: 0,
      releaseDate: '',
      addedAt: DateTime.now(),
    ));
    registerFallbackValue(const GetMovieReviewsParams(movieId: 1, page: 1));
  });

  setUp(() {
    mockGetMovieDetails = MockGetMovieDetails();
    mockGetMovieVideos = MockGetMovieVideos();
    mockGetMovieReviews = MockGetMovieReviews();
    mockAddFavorite = MockAddFavorite();
    mockRemoveFavorite = MockRemoveFavorite();
    bloc = MovieDetailBloc(
      getMovieDetails: mockGetMovieDetails,
      getMovieVideos: mockGetMovieVideos,
      getMovieReviews: mockGetMovieReviews,
      addFavorite: mockAddFavorite,
      removeFavorite: mockRemoveFavorite,
    );
  });

  tearDown(() {
    bloc.close();
  });

  const tMovieId = 1;
  const tMovieDetail = MovieDetailModel(
    id: tMovieId,
    title: 'Test Movie',
    overview: 'Test Overview',
    posterPath: '/test.jpg',
    backdropPath: '/backdrop.jpg',
    voteAverage: 8.5,
    voteCount: 1000,
    releaseDate: '2024-01-01',
    runtime: 120,
    genres: [],
    budget: 1000000,
    revenue: 5000000,
    status: 'Released',
    tagline: 'Test Tagline',
    productionCompanies: [],
    productionCountries: [],
    spokenLanguages: [],
  );

  group('LoadMovieDetail', () {
    test('initial state should be MovieDetailState with initial status', () {
      expect(bloc.state, equals(const MovieDetailState()));
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [loading, success] when loading movie detail succeeds',
      build: () {
        when(() => mockGetMovieDetails(any())).thenAnswer(
          (_) async => const Right(tMovieDetail),
        );
        when(() => mockGetMovieVideos(any())).thenAnswer(
          (_) async => const Right(VideoListResponse(id: tMovieId, results: [])),
        );
        when(() => mockGetMovieReviews(any())).thenAnswer(
          (_) async => const Right(ReviewListResponse(id: tMovieId, page: 1, results: [], totalPages: 1, totalResults: 0)),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadMovieDetail(tMovieId)),
      expect: () => [
        const MovieDetailState(status: MovieDetailStatus.loading),
        const MovieDetailState(
          status: MovieDetailStatus.success,
          movie: tMovieDetail,
        ),
      ],
      verify: (_) {
        verify(() => mockGetMovieDetails(tMovieId)).called(1);
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [loading, failure] when loading movie detail fails',
      build: () {
        when(() => mockGetMovieDetails(any())).thenAnswer(
          (_) async => Left(ServerFailure('Failed to load movie details')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadMovieDetail(tMovieId)),
      expect: () => [
        const MovieDetailState(status: MovieDetailStatus.loading),
        const MovieDetailState(
          status: MovieDetailStatus.failure,
          errorMessage: 'Failed to load movie details',
        ),
      ],
    );
  });

  group('ToggleFavorite', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'adds movie to favorites when not already favorited',
      build: () {
        when(() => mockAddFavorite(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return bloc;
      },
      seed: () => const MovieDetailState(
        status: MovieDetailStatus.success,
        movie: tMovieDetail,
        isFavorite: false,
      ),
      act: (bloc) => bloc.add(const ToggleFavorite()),
      expect: () => [
        const MovieDetailState(
          status: MovieDetailStatus.success,
          movie: tMovieDetail,
          isFavorite: true,
        ),
      ],
      verify: (_) {
        verify(() => mockAddFavorite(any())).called(1);
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'removes movie from favorites when already favorited',
      build: () {
        when(() => mockRemoveFavorite(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return bloc;
      },
      seed: () => const MovieDetailState(
        status: MovieDetailStatus.success,
        movie: tMovieDetail,
        isFavorite: true,
      ),
      act: (bloc) => bloc.add(const ToggleFavorite()),
      expect: () => [
        const MovieDetailState(
          status: MovieDetailStatus.success,
          movie: tMovieDetail,
          isFavorite: false,
        ),
      ],
      verify: (_) {
        verify(() => mockRemoveFavorite(tMovieId)).called(1);
      },
    );
  });
}
