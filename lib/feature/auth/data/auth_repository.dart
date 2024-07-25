import 'package:friends_list/feature/auth/data/auth_data_source.dart';
import 'package:friends_list/feature/auth/model/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> createUser({
    required String login,
    required String password,
  });

  Future<UserEntity?> getUserById({required int id});

  Future<bool> updateUser({
    required int id,
    required String login,
    required String password,
  });

  Future<int> deleteUser({required int id});

  Future<bool> login({
    required String login,
    required String password,
  });

  Future<UserEntity?> getLoginUser();

  Future<bool> logout({required int id});
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._dataSource);

  final UserDataSource _dataSource;

  @override
  Future<UserEntity> createUser({
    required String login,
    required String password,
  }) async {
    final createdUser =
        await _dataSource.createUser(login: login, password: password);

    return UserEntity.fromModel(createdUser);
  }

  @override
  Future<UserEntity?> getUserById({required int id}) async {
    final user = await _dataSource.getUserById(id: id);
    if (user != null) {
      return UserEntity.fromModel(user);
    } else {
      return null;
    }
  }

  @override
  Future<bool> updateUser({
    required int id,
    required String login,
    required String password,
  }) async {
    final updatedUser = await _dataSource.updateUser(
      id: id,
      login: login,
      password: password,
    );

    return updatedUser;
  }

  @override
  Future<int> deleteUser({required int id}) {
    return _dataSource.deleteUser(id: id);
  }

  @override
  Future<bool> login({
    required String login,
    required String password,
  }) async {
    return _dataSource.login(
      login: login,
      password: password,
    );
  }

  @override
  Future<UserEntity?> getLoginUser() async {
    final user = await _dataSource.getLoginUser();
    if (user != null) {
      return UserEntity.fromModel(user);
    }
    return null;
  }

  @override
  Future<bool> logout({required int id}) async {
    return _dataSource.logout(id: id);
  }
}
