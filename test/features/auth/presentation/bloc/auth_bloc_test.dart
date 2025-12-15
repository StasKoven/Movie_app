import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_discovery/core/error/failures.dart';
import 'package:movie_discovery/core/usecase/usecase.dart';
import 'package:movie_discovery/features/auth/data/models/user_model.dart';
import 'package:movie_discovery/features/auth/domain/usecases/sign_in.dart';
import 'package:movie_discovery/features/auth/domain/usecases/sign_up.dart';
import 'package:movie_discovery/features/auth/domain/usecases/sign_out.dart';
import 'package:movie_discovery/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movie_discovery/features/auth/presentation/bloc/auth_event.dart';
import 'package:movie_discovery/features/auth/presentation/bloc/auth_state.dart';

class MockSignIn extends Mock implements SignIn {}
class MockSignUp extends Mock implements SignUp {}
class MockSignOut extends Mock implements SignOut {}

void main() {
  late AuthBloc bloc;
  late MockSignIn mockSignIn;
  late MockSignUp mockSignUp;
  late MockSignOut mockSignOut;

  setUpAll(() {
    registerFallbackValue(const SignInParams(email: '', password: ''));
    registerFallbackValue(const SignUpParams(email: '', password: ''));
    registerFallbackValue(NoParams());
  });

  setUp(() {
    mockSignIn = MockSignIn();
    mockSignUp = MockSignUp();
    mockSignOut = MockSignOut();
    bloc = AuthBloc(
      signIn: mockSignIn,
      signUp: mockSignUp,
      signOut: mockSignOut,
    );
  });

  tearDown(() {
    bloc.close();
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tUser = UserModel(
    id: '123',
    email: tEmail,
    displayName: 'Test User',
  );

  group('SignInRequested', () {
    test('initial state should be AuthState with initial status', () {
      expect(bloc.state, equals(const AuthState()));
    });

    blocTest<AuthBloc, AuthState>(
      'emits [loading, authenticated] when sign in succeeds',
      build: () {
        when(() => mockSignIn(any())).thenAnswer(
          (_) async => const Right(tUser),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const SignInRequested(email: tEmail, password: tPassword),
      ),
      expect: () => [
        const AuthState(status: AuthStatus.loading),
        const AuthState(
          status: AuthStatus.authenticated,
          user: tUser,
        ),
      ],
      verify: (_) {
        verify(() => mockSignIn(
          SignInParams(email: tEmail, password: tPassword),
        )).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, failure] when sign in fails',
      build: () {
        when(() => mockSignIn(any())).thenAnswer(
          (_) async => Left(AuthenticationFailure('Invalid credentials')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const SignInRequested(email: tEmail, password: tPassword),
      ),
      expect: () => [
        const AuthState(status: AuthStatus.loading),
        const AuthState(
          status: AuthStatus.failure,
          errorMessage: 'Invalid credentials',
        ),
      ],
    );
  });

  group('SignUpRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits [loading, authenticated] when sign up succeeds',
      build: () {
        when(() => mockSignUp(any())).thenAnswer(
          (_) async => const Right(tUser),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const SignUpRequested(email: tEmail, password: tPassword),
      ),
      expect: () => [
        const AuthState(status: AuthStatus.loading),
        const AuthState(
          status: AuthStatus.authenticated,
          user: tUser,
        ),
      ],
      verify: (_) {
        verify(() => mockSignUp(
          SignUpParams(email: tEmail, password: tPassword),
        )).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, failure] when sign up fails',
      build: () {
        when(() => mockSignUp(any())).thenAnswer(
          (_) async => Left(AuthenticationFailure('Email already in use')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        const SignUpRequested(email: tEmail, password: tPassword),
      ),
      expect: () => [
        const AuthState(status: AuthStatus.loading),
        const AuthState(
          status: AuthStatus.failure,
          errorMessage: 'Email already in use',
        ),
      ],
    );
  });

  group('SignOutRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits [loading, unauthenticated] when sign out succeeds',
      build: () {
        when(() => mockSignOut(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const SignOutRequested()),
      expect: () => [
        const AuthState(status: AuthStatus.loading),
        const AuthState(status: AuthStatus.unauthenticated),
      ],
      verify: (_) {
        verify(() => mockSignOut(any())).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, failure] when sign out fails',
      build: () {
        when(() => mockSignOut(any())).thenAnswer(
          (_) async => Left(AuthenticationFailure('Sign out failed')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const SignOutRequested()),
      expect: () => [
        const AuthState(status: AuthStatus.loading),
        const AuthState(
          status: AuthStatus.failure,
          errorMessage: 'Sign out failed',
        ),
      ],
    );
  });
}
