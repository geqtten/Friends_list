import 'package:drift/drift.dart';
import 'package:friends_list/core/components/database/database.dart';
import 'package:friends_list/core/components/database/src/app_database.dart';
part "friend_data_source.g.dart";

abstract class FriendDataSource {
  Future<Friend> create({
    required String name,
    required String lastName,
  });
  Future<int> deleteFriend(int id);
  Future<List<Friend>> getAllFriends();
}

@DriftAccessor(tables: [AppDatabase])
class FriendDao extends DatabaseAccessor<AppDatabase>
    with _$FriendDaoMixin
    implements FriendDataSource {
  FriendDao(super.db);

  @override
  Future<Friend> create({
    required name,
    required lastName,
  }) async {
    return await db.into(db.friends).insertReturning(FriendsCompanion.insert(
          name: name,
          lastName: lastName,
        ));
  }

  @override
  Future<int> deleteFriend(int id) async {
    // Delete user with id 1
    return await (db.delete(db.friends)..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<List<Friend>> getAllFriends() async {
    return await db.select(db.friends).get();
  }
}
