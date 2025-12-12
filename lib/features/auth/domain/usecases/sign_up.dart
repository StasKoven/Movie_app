import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository_impl.dart';

class SignUpParams extends Equatable {
  final String email;
  final String password;

  const SignUpParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

@lazySingleton
class SignUp implements UseCase<UserModel, SignUpParams> {
  final AuthRepository repository;

  SignUp(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(SignUpParams params) async {
    return await repository.signUpWithEmail(params.email, params.password);
  }
}
