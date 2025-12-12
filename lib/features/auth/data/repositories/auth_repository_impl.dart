import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> signInWithEmail(String email, String password);
  Future<Either<Failure, UserModel>> signUpWithEmail(String email, String password);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserModel?>> getCurrentUser();
  Stream<UserModel?> get authStateChanges;
}

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserModel>> signInWithEmail(
      String email, String password) async {
    try {
      final user = await remoteDataSource.signInWithEmail(email, password);
      return Right(user);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmail(
      String email, String password) async {
    try {
      final user = await remoteDataSource.signUpWithEmail(email, password);
      return Right(user);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel?>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      return Right(user);
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(e.message));
    }
  }

  @override
  Stream<UserModel?> get authStateChanges => remoteDataSource.authStateChanges;
}
