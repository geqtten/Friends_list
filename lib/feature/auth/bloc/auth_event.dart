import 'package:flutter/foundation.dart';
import 'package:friends_list/core/utils/extensions/pattern_match.dart';

@immutable
sealed class AuthEvent extends _$UserEventBase {
  const AuthEvent();
  const factory AuthEvent.create(
    String login,
    String password,
  ) = AuthEvent$CreateUser;

  const factory AuthEvent.update(
    int id,
    String login,
    String password,
  ) = AuthEvent$Update;

  const factory AuthEvent.delete(int id) = AuthEvent$Delete;

  const factory AuthEvent.login(
    String login,
    String password,
  ) = AuthEvent$Login;

  const factory AuthEvent.getLogin() = AuthEvent$GetLogin;

  const factory AuthEvent.logout(int id) = AuthEvent$Logout;
}

final class AuthEvent$CreateUser extends AuthEvent {
  const AuthEvent$CreateUser(this.login, this.password) : super();

  final String login;
  final String password;
}

///
final class AuthEvent$Delete extends AuthEvent {
  const AuthEvent$Delete(this.id) : super();

  final int id;
}

final class AuthEvent$Update extends AuthEvent {
  const AuthEvent$Update(this.id, this.login, this.password) : super();

  final int id;
  final String login;
  final String password;
}

final class AuthEvent$Login extends AuthEvent {
  const AuthEvent$Login(this.login, this.password);

  final String login;
  final String password;
}

final class AuthEvent$GetLogin extends AuthEvent {
  const AuthEvent$GetLogin() : super();
}

final class AuthEvent$Logout extends AuthEvent {
  const AuthEvent$Logout(this.id);

  final int id;
}

///
abstract base class _$UserEventBase {
  const _$UserEventBase();

  ///
  R map<R>(
          {required PatternMatch<R, AuthEvent$CreateUser> create,
          required PatternMatch<R, AuthEvent$Update> update,
          required PatternMatch<R, AuthEvent$Login> login,
          required PatternMatch<R, AuthEvent$GetLogin> getLogin,
          required PatternMatch<R, AuthEvent$Logout> logout,
          required PatternMatch<R, AuthEvent$Delete> delete}) =>
      switch (this) {
        final AuthEvent$CreateUser s => create(s),
        final AuthEvent$Update s => update(s),
        final AuthEvent$Login s => login(s),
        final AuthEvent$GetLogin s => getLogin(s),
        final AuthEvent$Logout s => logout(s),
        final AuthEvent$Delete s => delete(s),
        _ => throw AssertionError(),
      };

  ///
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, AuthEvent$CreateUser>? create,
    PatternMatch<R, AuthEvent$Update>? update,
    PatternMatch<R, AuthEvent$Login>? login,
    PatternMatch<R, AuthEvent$GetLogin>? getLogin,
    PatternMatch<R, AuthEvent$Logout>? logout,
    PatternMatch<R, AuthEvent$Delete>? delete,
  }) =>
      map<R>(
        create: create ?? (_) => orElse(),
        update: update ?? (_) => orElse(),
        login: login ?? (_) => orElse(),
        getLogin: getLogin ?? (_) => orElse(),
        logout: logout ?? (_) => orElse(),
        delete: delete ?? (_) => orElse(),
      );

  ///
  R? mapOrNull<R>(
          {PatternMatch<R, AuthEvent$CreateUser>? create,
          PatternMatch<R, AuthEvent$Update>? update,
          PatternMatch<R, AuthEvent$Login>? login,
          PatternMatch<R, AuthEvent$GetLogin>? getLogin,
          PatternMatch<R, AuthEvent$Logout>? logout,
          PatternMatch<R, AuthEvent$Delete>? delete}) =>
      map<R?>(
        create: create ?? (_) => null,
        update: update ?? (_) => null,
        login: login ?? (_) => null,
        getLogin: getLogin ?? (_) => null,
        logout: logout ?? (_) => null,
        delete: delete ?? (_) => null,
      );
}
