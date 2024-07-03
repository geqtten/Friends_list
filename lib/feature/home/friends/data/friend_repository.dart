import 'package:friends_list/feature/home/friends/data/friend_data_source.dart';
import 'package:friends_list/feature/home/friends/model/friend_entity.dart';

abstract class FriendRepository {
  Future<FriendEntity> create({
    required String name,
    required String lastName,
  });

  Future<int> deleteFriend(int id);

  Future<List<FriendEntity>> getAllFriends();
}

class FriendRepositoryImpl implements FriendRepository {
  FriendRepositoryImpl(FriendDataSource dataSource) : _dataSource = dataSource;

  final FriendDataSource _dataSource;

  @override
  Future<FriendEntity> create({
    required String name,
    required String lastName,
  }) async {
    final newFriend = await _dataSource.create(
      name: name,
      lastName: lastName,
    );

    return FriendEntity.fromModel(newFriend);
  }

  @override
  Future<List<FriendEntity>> getAllFriends() async {
    final allFriends = await _dataSource.getAllFriends();
    if (allFriends.isNotEmpty) {
      return allFriends
          .map(
            (dto) => FriendEntity.fromModel(dto),
          )
          .toList();
    }
    return [];
  }

  @override
  Future<int> deleteFriend(int id) async {
    final deleteFriend = await _dataSource.deleteFriend(id);
    return deleteFriend;
  }
}
