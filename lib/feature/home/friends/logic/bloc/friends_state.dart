import 'package:flutter/foundation.dart';
import 'package:friends_list/feature/home/friends/model/friend_entity.dart';

import 'package:friends_list/core/utils/extensions/pattern_match.dart';

sealed class FriendState extends _$FriendStateBase {
  const FriendState._({
    super.friends = const [],
    super.error,
  });

  /// User is idle.
  const factory FriendState.idle(
      {List<FriendEntity> friends,
      FriendEntity? friend,
      String? error}) = _FriendState$Idle;

  /// User is loaded.
  const factory FriendState.loaded(
      {List<FriendEntity> friends,
      FriendEntity friend,
      String? error}) = _FriendState$Loaded;
}

/// [TaskState.idle] state matcher.
final class _FriendState$Idle extends FriendState {
  const _FriendState$Idle({super.friends, friend, super.error}) : super._();
}

/// [TaskState.loaded] state matcher.
final class _FriendState$Loaded extends FriendState {
  const _FriendState$Loaded({super.friends, friend, super.error}) : super._();
}

@immutable
abstract base class _$FriendStateBase {
  const _$FriendStateBase({required this.friends, this.error});

  @nonVirtual
  final List<FriendEntity> friends;

  @nonVirtual
  final String? error;

  bool get hasError => error != null;

  // ignore: unnecessary_null_comparison
  bool get hasFriend => friends != null;

  bool get isLoaded => maybeMap(
        loaded: (_) => true,
        orElse: () => false,
      );

  /// Indicator whether state is already idling.
  bool get isIdling => maybeMap(
        idle: (_) => true,
        orElse: () => false,
      );

  R map<R>({
    required PatternMatch<R, _FriendState$Idle> idle,
    required PatternMatch<R, _FriendState$Loaded> loaded,
  }) =>
      switch (this) {
        final _FriendState$Idle idleState => idle(idleState),
        final _FriendState$Loaded loadedState => loaded(loadedState),
        _ => throw UnsupportedError('Unsupported state: $this'),
      };
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, _FriendState$Idle>? idle,
    PatternMatch<R, _FriendState$Loaded>? loaded,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        loaded: loaded ?? (_) => orElse(),
      );

  @override
  String toString() =>
      'FriendState(FriendsList: ${friends.length},error: $error)';
}
