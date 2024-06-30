import 'dart:async';

import 'package:friends_list/core/components/database/src/app_database.dart';
import 'package:friends_list/feature/home/friends/data/friend_data_source.dart';
import 'package:friends_list/feature/home/friends/data/friend_repository.dart';

import '../model/initialization_progress.dart';

typedef StepAction = FutureOr<void>? Function(InitializationProgress progress);

mixin InitializationSteps {
  final initializationSteps = <String, StepAction>{
    "Database": (progress) {
      final database = AppDatabase();
      return progress.dependencies.database = database;
    },
    "FriendRepository": (progress) {
      final friendRepository =
          FriendRepositoryImpl(FriendDao(progress.dependencies.database));

      return progress.dependencies.friendRepository = friendRepository;
    },
  };
}
