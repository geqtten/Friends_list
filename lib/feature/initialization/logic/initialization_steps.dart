import 'dart:async';

import 'package:friends_list/core/components/database/database.dart';
import 'package:friends_list/core/components/router/router.dart';
import 'package:friends_list/feature/auth/data/auth_data_source.dart';
import 'package:friends_list/feature/auth/data/auth_repository.dart';
import 'package:friends_list/feature/home/friends/data/friend_data_source.dart';
import 'package:friends_list/feature/home/friends/data/friend_repository.dart';
import 'package:friends_list/feature/initialization/model/initialization_progress.dart';

typedef StepAction = FutureOr<void>? Function(InitializationProgress progress);

mixin InitializationSteps {
  final initializationSteps = <String, StepAction>{
    "Router": (progress) {
      final appRouter = AppRouter();
      return progress.dependencies.appRouter = appRouter;
    },
    "Database": (progress) {
      final db = AppDatabase();
      return progress.dependencies.database = db;
    },
    "AuthRepository": (progress) {
      final authRepository = AuthRepositoryImpl(
        AuthDao(progress.dependencies.database),
      );
      return progress.dependencies.authRepository = authRepository;
    },
    "FriendRepository": (progress) {
      final friendRepository =
          FriendRepositoryImpl(FriendDao(progress.dependencies.database));

      return progress.dependencies.friendRepository = friendRepository;
    },
  };
}
