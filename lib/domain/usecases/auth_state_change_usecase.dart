import 'package:firebase_auth_bloc/data/repository/auth_repository_impl.dart';
import 'package:firebase_auth_bloc/domain/entity/user_entity.dart';

class AuthStateChangeUsecase {
  final AuthRepositoryImpl _repository;

  AuthStateChangeUsecase({required AuthRepositoryImpl repository}) : _repository = repository;

  Stream<UserEntity?> call() {
    return _repository.authStateChanges;
  }
}
