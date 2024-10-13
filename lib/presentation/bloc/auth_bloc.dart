import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth_bloc/core/usecase/core_usecase.dart';
import 'package:firebase_auth_bloc/domain/entity/user_entity.dart';
import 'package:firebase_auth_bloc/domain/usecases/auth_state_change_usecase.dart';
import 'package:firebase_auth_bloc/domain/usecases/login_usecase.dart';
import 'package:firebase_auth_bloc/domain/usecases/logout_usecase.dart';
import 'package:firebase_auth_bloc/domain/usecases/register_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase _loginUsecase;
  final RegisterUsecase _registerUsecase;
  final LogoutUsecase _logoutUsecase;
  final AuthStateChangeUsecase _authStateChangeUsecase;
  late StreamSubscription<UserEntity?> _authStateSubscription;

  AuthBloc({
    required LoginUsecase loginUsecase,
    required RegisterUsecase registerUsecase,
    required LogoutUsecase logoutUsecase,
    required AuthStateChangeUsecase authStateChangeUsecase,
  })  : _loginUsecase = loginUsecase,
        _registerUsecase = registerUsecase,
        _logoutUsecase = logoutUsecase,
        _authStateChangeUsecase = authStateChangeUsecase,
        super(AuthInitial()) {
    on<AuthStateChangedEvent>(_onAuthStateChanged);
    on<LogInEvent>(_onLogIn);
    on<RegisterEvent>(_onRegister);
    on<LogOutEvent>(_onLogOut);

    _authStateSubscription = _authStateChangeUsecase().listen((user) {
      add(AuthStateChangedEvent(user));
    });
  }

  Future<void> _onAuthStateChanged(AuthStateChangedEvent event, Emitter<AuthState> emit) async {
    if (event.user != null) {
      emit(Authenticated(event.user!));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLogIn(LogInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _loginUsecase(LoginParams(
      email: event.email,
      password: event.password,
    ));
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) {},
    );
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _registerUsecase(RegisterParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) {},
    );
  }

  Future<void> _onLogOut(LogOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _logoutUsecase(NoParams());
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) {},
    );
  }

  @override
  Future<void> close() {
    _authStateSubscription.cancel();
    return super.close();
  }
}
