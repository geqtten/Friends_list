import 'package:friends_list/core/components/database/database.dart';
import 'package:friends_list/core/components/router/router.dart';
import 'package:friends_list/feature/auth/data/auth_repository.dart';
import 'package:friends_list/feature/home/friends/data/friend_repository.dart';

base class Dependencies {
  Dependencies();

  late final AppDatabase database;
  late final AuthRepository authRepository;
  late final AppRouter appRouter;
  late final FriendRepository friendRepository;
}

final class InitializationResult {
  InitializationResult(
      {required this.dependencies,
      required this.stepCount,
      required this.msSpent});

  final Dependencies dependencies;
  final int stepCount;
  final int msSpent;

  @override
  String toString() => '$InitializationResult('
      'dependencies: $dependencies, '
      'stepCount: $stepCount, '
      'msSpent: $msSpent'
      ')';
}
