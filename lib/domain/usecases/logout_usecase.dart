import 'package:firebase_auth_bloc/core/failure.dart';
import 'package:firebase_auth_bloc/core/usecase/core_usecase.dart';
import 'package:firebase_auth_bloc/data/repository/auth_repository_impl.dart';
import 'package:fpdart/fpdart.dart';

class LogoutUsecase implements CoreUsecases<void, NoParams> {
  final AuthRepositoryImpl _repository;

  LogoutUsecase({required AuthRepositoryImpl repository}) : _repository = repository;
  @override
  Future<Either<Failure, void>> call(NoParams input) async {
    return await _repository.signOut();
  }
}
