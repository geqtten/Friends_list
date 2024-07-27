import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends_list/feature/auth/model/user_entity.dart';
import 'package:friends_list/core/utils/extensions/context_extension.dart';

import '../../initialization/widget/dependencies_scope.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

abstract interface class AuthController {
  /// Signs in the user with the given [email] and [password].
  void login(String email, String password);
  void signUp(String email, String password);
  void logout();
  void getLogin();
  bool get hasLogin;
  bool get hasLogout;
  String? get error;
  AuthState get authState;
  UserEntity? get loginUser;
}

class AuthScope extends StatefulWidget {
  /// Create an [AuthScope] widget.
  const AuthScope({
    required this.child,
    super.key,
  });

  /// Child widget of this scope.
  final Widget child;

  /// Obtain the nearest [AuthController] up its widget tree.
  static AuthController of(BuildContext context, {bool listen = true}) =>
      context.inhOf<_AuthInherited>(listen: listen).authController;

  @override
  State<AuthScope> createState() => _AuthScopeState();
}

class _AuthScopeState extends State<AuthScope> implements AuthController {
  late final AuthBloc _authBloc;
  late AuthState _authState;

  @override
  void initState() {
    _authBloc =
        AuthBloc(authRepository: DependenciesScope.of(context).authRepository);
    _authState = _authBloc.state;
    _authBloc.add(const AuthEvent.getLogin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthBloc, AuthState>(
        bloc: _authBloc,
        builder: (context, state) {
          _authState = state;
          return _AuthInherited(
            authController: this,
            authState: state,
            child: widget.child,
          );
        },
      );

  @override
  void login(String email, String password) => _authBloc.add(
        AuthEvent.login(
          email,
          password,
        ),
      );

  @override
  void signUp(String email, String password) => _authBloc.add(
        AuthEvent.create(
          email,
          password,
        ),
      );

  @override
  void logout() => _authBloc.add(AuthEvent.logout(_authState.user!.id));

  @override
  void getLogin() => _authBloc.add(const AuthEvent.getLogin());

  @override
  bool get hasLogin {
    if (_authState.isLogin != null) {
      return _authState.isLogin!;
    }
    return false;
  }

  @override
  bool get hasLogout {
    if (_authState.isLogin != null) {
      return _authState.isLogin!;
    }
    return false;
  }

  @override
  String? get error => _authState.error;

  @override
  AuthState get authState => _authState;

  @override
  UserEntity? get loginUser => _authState.user;
}

/// Inherited widget that passes the [AuthController] down the widget tree.
class _AuthInherited extends InheritedWidget {
  const _AuthInherited({
    required super.child,
    required this.authController,
    required AuthState authState,
  }) : _authState = authState;

  /// Auth controller
  final AuthController authController;

  final AuthState _authState;

  @override
  bool updateShouldNotify(_AuthInherited oldWidget) =>
      _authState != oldWidget._authState;
}
