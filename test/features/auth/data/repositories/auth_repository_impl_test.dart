import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_discovery/core/error/exceptions.dart';
import 'package:movie_discovery/core/error/failures.dart';
import 'package:movie_discovery/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:movie_discovery/features/auth/data/models/user_model.dart';
import 'package:movie_discovery/features/auth/data/repositories/auth_repository_impl.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tUser = UserModel(
    id: '123',
    email: tEmail,
    displayName: 'Test User',
  );

  group('signInWithEmail', () {
    test('should return user when sign in is successful', () async {
      // arrange
      when(() => mockRemoteDataSource.signInWithEmail(tEmail, tPassword))
          .thenAnswer((_) async => tUser);

      // act
      final result = await repository.signInWithEmail(tEmail, tPassword);

      // assert
      expect(result, equals(const Right(tUser)));
      verify(() => mockRemoteDataSource.signInWithEmail(tEmail, tPassword))
          .called(1);
    });

    test('should return AuthenticationFailure when sign in fails', () async {
      // arrange
      when(() => mockRemoteDataSource.signInWithEmail(tEmail, tPassword))
          .thenThrow(AuthenticationException('Invalid credentials'));

      // act
      final result = await repository.signInWithEmail(tEmail, tPassword);

      // assert
      expect(
        result,
        equals(Left(AuthenticationFailure('Invalid credentials'))),
      );
    });
  });

  group('signUpWithEmail', () {
    test('should return user when sign up is successful', () async {
      // arrange
      when(() => mockRemoteDataSource.signUpWithEmail(tEmail, tPassword))
          .thenAnswer((_) async => tUser);

      // act
      final result = await repository.signUpWithEmail(tEmail, tPassword);

      // assert
      expect(result, equals(const Right(tUser)));
      verify(() => mockRemoteDataSource.signUpWithEmail(tEmail, tPassword))
          .called(1);
    });

    test('should return AuthenticationFailure when sign up fails', () async {
      // arrange
      when(() => mockRemoteDataSource.signUpWithEmail(tEmail, tPassword))
          .thenThrow(AuthenticationException('Email already in use'));

      // act
      final result = await repository.signUpWithEmail(tEmail, tPassword);

      // assert
      expect(
        result,
        equals(Left(AuthenticationFailure('Email already in use'))),
      );
    });
  });

  group('signOut', () {
    test('should return Right when sign out is successful', () async {
      // arrange
      when(() => mockRemoteDataSource.signOut()).thenAnswer((_) async {});

      // act
      final result = await repository.signOut();

      // assert
      expect(result, equals(const Right(null)));
      verify(() => mockRemoteDataSource.signOut()).called(1);
    });

    test('should return AuthenticationFailure when sign out fails', () async {
      // arrange
      when(() => mockRemoteDataSource.signOut())
          .thenThrow(AuthenticationException('Sign out failed'));

      // act
      final result = await repository.signOut();

      // assert
      expect(
        result,
        equals(Left(AuthenticationFailure('Sign out failed'))),
      );
    });
  });

  group('getCurrentUser', () {
    test('should return user when getting current user is successful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getCurrentUser())
          .thenAnswer((_) async => tUser);

      // act
      final result = await repository.getCurrentUser();

      // assert
      expect(result, equals(const Right(tUser)));
      verify(() => mockRemoteDataSource.getCurrentUser()).called(1);
    });

    test('should return null when no user is signed in', () async {
      // arrange
      when(() => mockRemoteDataSource.getCurrentUser())
          .thenAnswer((_) async => null);

      // act
      final result = await repository.getCurrentUser();

      // assert
      expect(result, equals(const Right(null)));
    });
  });
}
