import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository}) : super(const AuthState.idle()) {
    on<AuthEvent>(
      (event, emit) => event.map(
          create: (e) => _create(e, emit),
          update: (e) => _update(e, emit),
          delete: (e) => _delete(e, emit),
          login: (e) => _login(e, emit),
          getLogin: (e) => _getLogin(e, emit),
          logout: (e) => _logout(e, emit)),
    );
  }

  final AuthRepository authRepository;

  Future<void> _create(
      AuthEvent$CreateUser event, Emitter<AuthState> emit) async {
    try {
      final newUser = await authRepository.createUser(
        login: event.login,
        password: event.password,
      );
      final user = await authRepository.getUserById(id: newUser.id);
      if (user != null) {
        emit(
          AuthState.loaded(user: user),
        );
      } else {
        emit(const AuthState.idle(error: "User is not found"));
      }
    } on Object catch (e) {
      emit(AuthState.idle(error: e.toString()));
      rethrow;
    }
  }

  Future<void> _update(AuthEvent$Update event, Emitter<AuthState> emit) async {
    try {
      final updatedUser = await authRepository.updateUser(
        id: event.id,
        login: event.login,
        password: event.password,
      );
      final user = await authRepository.getUserById(id: event.id);
      if (user != null && updatedUser) {
        emit(
          AuthState.loaded(user: user),
        );
      } else {
        emit(const AuthState.idle(error: "User is not found"));
      }
    } on Object catch (e) {
      emit(AuthState.idle(error: e.toString()));
      rethrow;
    }
  }

  Future<void> _delete(AuthEvent$Delete event, Emitter<AuthState> emit) async {
    try {
      final isDeleted = await authRepository.deleteUser(id: event.id);
      final user = await authRepository.getLoginUser();

      if (isDeleted != 0 && user != null) {
        emit(
          AuthState.loaded(user: user),
        );
      } else {
        emit(const AuthState.idle(error: "User is not found"));
      }
    } on Object catch (e) {
      emit(AuthState.idle(error: e.toString()));
      rethrow;
    }
  }

  Future<void> _login(AuthEvent$Login event, Emitter<AuthState> emit) async {
    try {
      final isLogin = await authRepository.login(
        login: event.login,
        password: event.password,
      );
      final user = await authRepository.getLoginUser();

      if (isLogin && user != null) {
        emit(AuthState.loaded(user: user, isLogin: true));
      } else {
        emit(const AuthState.idle(error: "User is not found", isLogin: false));
      }
    } on Object catch (e) {
      emit(AuthState.idle(error: e.toString()));
      rethrow;
    }
  }

  Future<void> _getLogin(
      AuthEvent$GetLogin event, Emitter<AuthState> emit) async {
    try {
      final user = await authRepository.getLoginUser();
      if (user != null) {
        emit(AuthState.loaded(user: user, isLogin: true));
      } else {
        emit(const AuthState.idle(isLogin: false));
      }
    } on Object catch (e) {
      emit(AuthState.idle(error: e.toString()));
      rethrow;
    }
  }

  Future<void> _logout(AuthEvent$Logout event, Emitter<AuthState> emit) async {
    try {
      final isLogout = await authRepository.logout(id: event.id);
      final user = await authRepository.getLoginUser();

      if (isLogout && user != null) {
        emit(
          AuthState.loaded(user: user),
        );
      } else {
        emit(const AuthState.idle(error: "User is not found"));
      }
    } on Object catch (e) {
      emit(AuthState.idle(error: e.toString()));
      rethrow;
    }
  }
}

class AuthStateNotifier extends ChangeNotifier {
  late final StreamSubscription<AuthState> _blocStream;
  authStateProvider(AuthBloc bloc) {
    _blocStream = bloc.stream.listen((event) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();

    _blocStream.cancel();
  }
}
