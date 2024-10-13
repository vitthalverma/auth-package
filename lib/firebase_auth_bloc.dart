library firebase_auth_bloc;

import 'package:firebase_auth_bloc/data/datasource/firebase_auth_datasource.dart';
import 'package:firebase_auth_bloc/data/repository/auth_repository_impl.dart';
import 'package:firebase_auth_bloc/domain/usecases/auth_state_change_usecase.dart';
import 'package:firebase_auth_bloc/domain/usecases/login_usecase.dart';
import 'package:firebase_auth_bloc/domain/usecases/logout_usecase.dart';
import 'package:firebase_auth_bloc/domain/usecases/register_usecase.dart';
import 'package:firebase_auth_bloc/presentation/bloc/auth_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthBlocInitializer {
  static Future<void> initialize({
    required FirebaseOptions firebaseOptions,
  }) async {
    await Firebase.initializeApp(options: firebaseOptions);
  }

  static AuthBloc createAuthBloc() {
    final dataSource = FirebaseAuthDataSource();
    final repository = AuthRepositoryImpl(dataSource: dataSource);

    return AuthBloc(
      loginUsecase: LoginUsecase(repository: repository),
      registerUsecase: RegisterUsecase(repository: repository),
      logoutUsecase: LogoutUsecase(repository: repository),
      authStateChangeUsecase: AuthStateChangeUsecase(repository: repository),
    );
  }
}
