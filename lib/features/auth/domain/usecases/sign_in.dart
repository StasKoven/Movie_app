import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository_impl.dart';

class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

@lazySingleton
class SignIn implements UseCase<UserModel, SignInParams> {
  final AuthRepository repository;

  SignIn(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(SignInParams params) async {
    return await repository.signInWithEmail(params.email, params.password);
  }
}
