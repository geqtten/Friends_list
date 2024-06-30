import 'package:friends_list/core/components/database/database.dart';

import '../../../../core/components/database/src/app_database.dart';

class FriendEntity {
  const FriendEntity({
    required this.id,
    required this.name,
    required this.lastName,
  });

  final int id;
  final String name;
  final String lastName;

  factory FriendEntity.fromModel(Friend model) {
    return FriendEntity(
      id: model.id,
      name: model.name,
      lastName: model.lastName,
    );
  }
}
