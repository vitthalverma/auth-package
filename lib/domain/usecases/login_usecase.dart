import 'package:firebase_auth_bloc/core/failure.dart';
import 'package:firebase_auth_bloc/core/usecase/core_usecase.dart';
import 'package:firebase_auth_bloc/data/repository/auth_repository_impl.dart';
import 'package:firebase_auth_bloc/domain/entity/user_entity.dart';
import 'package:fpdart/fpdart.dart';

class LoginUsecase implements CoreUsecases<UserEntity, LoginParams> {
  final AuthRepositoryImpl _repository;

  LoginUsecase({required AuthRepositoryImpl repository}) : _repository = repository;
  @override
  Future<Either<Failure, UserEntity>> call(LoginParams input) async {
    return await _repository.login(email: input.email, password: input.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
