import 'package:flutter/foundation.dart';
import 'package:friends_list/core/utils/extensions/pattern_match.dart';

@immutable
sealed class FriendEvent extends _$UserEventBase {
  const FriendEvent();

  const factory FriendEvent.create(String name, String lastName) =
      FriendEvent$Create;

  const factory FriendEvent.loadAllFriends() = FriendsEvent$LoadAllFriends;

  const factory FriendEvent.deleteFriend(int id) = FriendsEvent$DeleteFriend;
}

final class FriendEvent$Create extends FriendEvent {
  const FriendEvent$Create(this.name, this.lastName) : super();

  final String name;
  final String lastName;
}

final class FriendsEvent$LoadAllFriends extends FriendEvent {
  const FriendsEvent$LoadAllFriends() : super();
}

final class FriendsEvent$DeleteFriend extends FriendEvent {
  const FriendsEvent$DeleteFriend(this.id) : super();

  final int id;
}

///
abstract base class _$UserEventBase {
  const _$UserEventBase();

  ///
  R map<R>({
    required PatternMatch<R, FriendEvent$Create> create,
    required PatternMatch<R, FriendsEvent$LoadAllFriends> loadAllFriends,
    required PatternMatch<R, FriendsEvent$DeleteFriend> deleteFriend,
  }) =>
      switch (this) {
        final FriendEvent$Create s => create(s),
        final FriendsEvent$LoadAllFriends s => loadAllFriends(s),
        final FriendsEvent$DeleteFriend s => deleteFriend(s),
        _ => throw AssertionError(),
      };

  ///
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, FriendEvent$Create>? create,
    PatternMatch<R, FriendsEvent$LoadAllFriends>? loadAllFriends,
    PatternMatch<R, FriendsEvent$DeleteFriend>? deleteFriend,
  }) =>
      map<R>(
        create: create ?? (_) => orElse(),
        loadAllFriends: loadAllFriends ?? (_) => orElse(),
        deleteFriend: deleteFriend ?? (_) => orElse(),
      );

  ///
  R? mapOrNull<R>({
    PatternMatch<R, FriendEvent$Create>? create,
    PatternMatch<R, FriendsEvent$LoadAllFriends>? loadAllFriends,
    PatternMatch<R, FriendsEvent$DeleteFriend>? deleteFriend,
  }) =>
      map<R?>(
        create: create ?? (_) => null,
        loadAllFriends: loadAllFriends ?? (_) => null,
        deleteFriend: deleteFriend ?? (_) => null,
      );
}
