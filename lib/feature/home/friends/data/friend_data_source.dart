import 'dart:core';
import 'package:drift/drift.dart';
import 'package:friends_list/core/components/database/database.dart';
import 'package:friends_list/core/components/database/src/app_database.dart';
import 'package:friends_list/core/components/database/src/tables/friends_table.dart';
part "friend_data_source.g.dart";

abstract class FriendDataSource {
  Future<Friend> createFriend({
    required String name,
    required String lastName,
  });
  Future<int> deleteFriend(int id);
  Future<List<Friend>> getAllFriends();
  Future<int> updateFriend({
    required int id,
    required String name,
    required String lastName,
  });
}

@DriftAccessor(tables: [Friends])
class FriendDao extends DatabaseAccessor<AppDatabase>
    with _$FriendDaoMixin
    implements FriendDataSource {
  FriendDao(super.db);

  @override
  Future<Friend> createFriend({
    required String name,
    required String lastName,
  }) async {
    return await db.into(db.friends).insertReturning(FriendsCompanion.insert(
          name: name,
          lastName: lastName,
        ));
  }

  @override
  Future<int> deleteFriend(int id) async {
    return await (db.delete(db.friends)..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<int> updateFriend({
    required int id,
    required String name,
    required String lastName,
  }) async {
// Conditional update for users
    return await (db.update(db.friends)..where((tbl) => tbl.id.equals(id)))
        .write(FriendsCompanion(name: Value(name), lastName: Value(lastName)));
  }

  @override
  Future<List<Friend>> getAllFriends() async {
    return await db.select(db.friends).get();
  }
}
