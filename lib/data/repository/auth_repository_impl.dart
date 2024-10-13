import 'package:firebase_auth_bloc/core/failure.dart';
import 'package:firebase_auth_bloc/data/datasource/firebase_auth_datasource.dart';
import 'package:firebase_auth_bloc/domain/entity/user_entity.dart';
import 'package:firebase_auth_bloc/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _dataSource;

  AuthRepositoryImpl({required FirebaseAuthDataSource dataSource}) : _dataSource = dataSource;
  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _dataSource.login(email: email, password: password);
      return right(userModel);
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _dataSource.register(
        name: name,
        email: email,
        password: password,
      );
      return right(userModel);
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _dataSource.logout();
      return right(null);
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Stream<UserEntity?> get authStateChanges => _dataSource.authStateChanges;
}
