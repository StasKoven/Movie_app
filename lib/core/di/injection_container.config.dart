// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;

import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/usecases/sign_in.dart' as _i920;
import '../../features/auth/domain/usecases/sign_out.dart' as _i568;
import '../../features/auth/domain/usecases/sign_up.dart' as _i190;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../../features/favorites/data/datasources/favorites_local_data_source.dart'
    as _i654;
import '../../features/favorites/data/repositories/favorites_repository_impl.dart'
    as _i144;
import '../../features/favorites/domain/usecases/add_favorite.dart' as _i705;
import '../../features/favorites/domain/usecases/get_all_favorites.dart'
    as _i298;
import '../../features/favorites/domain/usecases/remove_favorite.dart' as _i828;
import '../../features/favorites/presentation/bloc/favorites_bloc.dart'
    as _i429;
import '../../features/home/data/datasources/movie_local_data_source.dart'
    as _i478;
import '../../features/home/data/datasources/movie_remote_data_source.dart'
    as _i200;
import '../../features/home/data/repositories/movie_repository_impl.dart'
    as _i449;
import '../../features/home/domain/usecases/discover_movies.dart' as _i452;
import '../../features/home/domain/usecases/get_movie_details.dart' as _i826;
import '../../features/home/domain/usecases/get_movie_reviews.dart' as _i300;
import '../../features/home/domain/usecases/get_movie_videos.dart' as _i108;
import '../../features/home/domain/usecases/get_popular_movies.dart' as _i539;
import '../../features/home/domain/usecases/get_top_rated_movies.dart' as _i579;
import '../../features/home/domain/usecases/get_upcoming_movies.dart' as _i404;
import '../../features/home/domain/usecases/search_movies.dart' as _i114;
import '../../features/home/presentation/bloc/movie_bloc.dart' as _i37;
import '../../features/home/presentation/bloc/movie_detail_bloc.dart' as _i379;
import '../../features/home/presentation/bloc/search_bloc.dart' as _i511;
import '../database/app_database.dart' as _i982;
import '../network/dio_client.dart' as _i667;
import '../network/network_info.dart' as _i932;
import 'firebase_module.dart' as _i616;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseModule = _$FirebaseModule();
    final networkModule = _$NetworkModule();
    gh.factory<_i667.DioClient>(() => _i667.DioClient());
    gh.singleton<_i982.AppDatabase>(() => _i982.AppDatabase());
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i478.MovieLocalDataSource>(
        () => _i478.MovieLocalDataSourceImpl());
    gh.lazySingleton<_i932.NetworkInfo>(() => _i932.NetworkInfoImpl(
          connectionChecker: gh<_i161.InternetConnection>(),
          connectivity: gh<_i895.Connectivity>(),
        ));
    gh.lazySingleton<_i654.FavoritesLocalDataSource>(
        () => _i654.FavoritesLocalDataSourceImpl());
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio(gh<_i667.DioClient>()));
    gh.lazySingleton<_i107.AuthRemoteDataSource>(() =>
        _i107.AuthRemoteDataSourceImpl(firebaseAuth: gh<_i59.FirebaseAuth>()));
    gh.lazySingleton<_i200.MovieRemoteDataSource>(
        () => _i200.MovieRemoteDataSourceImpl(dio: gh<_i361.Dio>()));
    gh.lazySingleton<_i144.FavoritesRepository>(() =>
        _i144.FavoritesRepositoryImpl(
            localDataSource: gh<_i654.FavoritesLocalDataSource>()));
    gh.lazySingleton<_i705.AddFavorite>(
        () => _i705.AddFavorite(gh<_i144.FavoritesRepository>()));
    gh.lazySingleton<_i298.GetAllFavorites>(
        () => _i298.GetAllFavorites(gh<_i144.FavoritesRepository>()));
    gh.lazySingleton<_i828.RemoveFavorite>(
        () => _i828.RemoveFavorite(gh<_i144.FavoritesRepository>()));
    gh.lazySingleton<_i153.AuthRepository>(() => _i153.AuthRepositoryImpl(
        remoteDataSource: gh<_i107.AuthRemoteDataSource>()));
    gh.lazySingleton<_i920.SignIn>(
        () => _i920.SignIn(gh<_i153.AuthRepository>()));
    gh.lazySingleton<_i568.SignOut>(
        () => _i568.SignOut(gh<_i153.AuthRepository>()));
    gh.lazySingleton<_i190.SignUp>(
        () => _i190.SignUp(gh<_i153.AuthRepository>()));
    gh.lazySingleton<_i449.MovieRepository>(() => _i449.MovieRepositoryImpl(
          remoteDataSource: gh<_i200.MovieRemoteDataSource>(),
          localDataSource: gh<_i478.MovieLocalDataSource>(),
          networkInfo: gh<_i932.NetworkInfo>(),
          database: gh<_i982.AppDatabase>(),
        ));
    gh.factory<_i429.FavoritesBloc>(() => _i429.FavoritesBloc(
          getAllFavorites: gh<_i298.GetAllFavorites>(),
          addFavorite: gh<_i705.AddFavorite>(),
          removeFavorite: gh<_i828.RemoveFavorite>(),
        ));
    gh.lazySingleton<_i452.DiscoverMovies>(
        () => _i452.DiscoverMovies(gh<_i449.MovieRepository>()));
    gh.lazySingleton<_i826.GetMovieDetails>(
        () => _i826.GetMovieDetails(gh<_i449.MovieRepository>()));
    gh.lazySingleton<_i300.GetMovieReviews>(
        () => _i300.GetMovieReviews(gh<_i449.MovieRepository>()));
    gh.lazySingleton<_i108.GetMovieVideos>(
        () => _i108.GetMovieVideos(gh<_i449.MovieRepository>()));
    gh.lazySingleton<_i539.GetPopularMovies>(
        () => _i539.GetPopularMovies(gh<_i449.MovieRepository>()));
    gh.lazySingleton<_i579.GetTopRatedMovies>(
        () => _i579.GetTopRatedMovies(gh<_i449.MovieRepository>()));
    gh.lazySingleton<_i404.GetUpcomingMovies>(
        () => _i404.GetUpcomingMovies(gh<_i449.MovieRepository>()));
    gh.lazySingleton<_i114.SearchMovies>(
        () => _i114.SearchMovies(gh<_i449.MovieRepository>()));
    gh.factory<_i797.AuthBloc>(() => _i797.AuthBloc(
          signIn: gh<_i920.SignIn>(),
          signUp: gh<_i190.SignUp>(),
          signOut: gh<_i568.SignOut>(),
        ));
    gh.factory<_i379.MovieDetailBloc>(() => _i379.MovieDetailBloc(
          getMovieDetails: gh<_i826.GetMovieDetails>(),
          getMovieVideos: gh<_i108.GetMovieVideos>(),
          getMovieReviews: gh<_i300.GetMovieReviews>(),
          addFavorite: gh<_i705.AddFavorite>(),
          removeFavorite: gh<_i828.RemoveFavorite>(),
        ));
    gh.factory<_i37.MovieBloc>(() => _i37.MovieBloc(
          getPopularMovies: gh<_i539.GetPopularMovies>(),
          getTopRatedMovies: gh<_i579.GetTopRatedMovies>(),
          getUpcomingMovies: gh<_i404.GetUpcomingMovies>(),
        ));
    gh.factory<_i511.SearchBloc>(
        () => _i511.SearchBloc(searchMovies: gh<_i114.SearchMovies>()));
    return this;
  }
}

class _$FirebaseModule extends _i616.FirebaseModule {}

class _$NetworkModule extends _i667.NetworkModule {}
