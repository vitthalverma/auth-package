import 'package:firebase_auth_bloc/core/failure.dart';
import 'package:firebase_auth_bloc/core/usecase/core_usecase.dart';
import 'package:firebase_auth_bloc/data/repository/auth_repository_impl.dart';
import 'package:firebase_auth_bloc/domain/entity/user_entity.dart';
import 'package:fpdart/fpdart.dart';

class RegisterUsecase implements CoreUsecases<UserEntity, RegisterParams> {
  final AuthRepositoryImpl _repository;

  RegisterUsecase({required AuthRepositoryImpl repository}) : _repository = repository;
  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams input) async {
    return await _repository.register(name: input.name, email: input.email, password: input.password);
  }
}

class RegisterParams {
  final String name;
  final String email;
  final String password;

  RegisterParams({required this.name, required this.email, required this.password});
}
