import 'package:firebase_auth_bloc/core/failure.dart';
import 'package:firebase_auth_bloc/domain/entity/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> signOut();
  Stream<UserEntity?> get authStateChanges;
//  Future<Either<Failure, User>> getCurrentUser();
}
