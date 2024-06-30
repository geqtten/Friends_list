import 'package:drift/drift.dart';
import 'package:friends_list/core/components/database/database.dart';
import 'package:friends_list/core/components/database/src/app_database.dart';
part "friend_data_source.g.dart";

abstract class FriendDataSource {
  Future<Friend> create({
    required String name,
    required String lastName,
  });
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
  }) {
    return db.into(db.friends).insertReturning(FriendsCompanion.insert(
          name: name,
          lastName: lastName,
        ));
  }

  @override
  Future<List<Friend>> getAllFriends() async {
    return await db.select(db.friends).get();
  }
}
