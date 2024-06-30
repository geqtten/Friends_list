import 'package:flutter/foundation.dart';
import 'package:friends_list/core/utils/extensions/pattern_match.dart';

@immutable
sealed class FriendEvent extends _$UserEventBase {
  const FriendEvent();

  const factory FriendEvent.create(String name, String lastName) =
      FriendEvent$Create;

  const factory FriendEvent.loadAllFriends() = FriendsEvent$LoadAllFriends;
}

final class FriendEvent$Create extends FriendEvent {
  const FriendEvent$Create(this.name, this.lastName) : super();

  final String name;
  final String lastName;
}

final class FriendsEvent$LoadAllFriends extends FriendEvent {
  const FriendsEvent$LoadAllFriends() : super();
}

///
abstract base class _$UserEventBase {
  const _$UserEventBase();

  ///
  R map<R>({
    required PatternMatch<R, FriendEvent$Create> create,
    required PatternMatch<R, FriendsEvent$LoadAllFriends> loadAllFriends,
  }) =>
      switch (this) {
        final FriendEvent$Create s => create(s),
        final FriendsEvent$LoadAllFriends s => loadAllFriends(s),
        _ => throw AssertionError(),
      };

  ///
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, FriendEvent$Create>? create,
    PatternMatch<R, FriendsEvent$LoadAllFriends>? loadAllFriends,
  }) =>
      map<R>(
        create: create ?? (_) => orElse(),
        loadAllFriends: loadAllFriends ?? (_) => orElse(),
      );

  ///
  R? mapOrNull<R>({
    PatternMatch<R, FriendEvent$Create>? create,
    PatternMatch<R, FriendsEvent$LoadAllFriends>? loadAllFriends,
  }) =>
      map<R?>(
        create: create ?? (_) => null,
        loadAllFriends: loadAllFriends ?? (_) => null,
      );
}
