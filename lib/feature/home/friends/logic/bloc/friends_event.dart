import 'package:flutter/foundation.dart';
import 'package:friends_list/core/utils/extensions/pattern_match.dart';

@immutable
sealed class FriendEvent extends _$UserEventBase {
  const FriendEvent();

  const factory FriendEvent.createFriend(
    String name,
    String lastName,
  ) = FriendsEvent$CreateFriend;

  const factory FriendEvent.loadAllFriends() = FriendsEvent$LoadAllFriends;

  const factory FriendEvent.deleteFriend(int id) = FriendsEvent$DeleteFriend;

  const factory FriendEvent.updateFriend(
    String name,
    String lastName,
    int id,
  ) = FriendsEvent$UpdateFriend;
  const factory FriendEvent.getFriendsByName(String name) =
      FriendsEvent$GetFriendsByName;
}

final class FriendsEvent$CreateFriend extends FriendEvent {
  const FriendsEvent$CreateFriend(this.name, this.lastName) : super();

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

final class FriendsEvent$UpdateFriend extends FriendEvent {
  const FriendsEvent$UpdateFriend(this.name, this.lastName, this.id) : super();

  final int id;
  final String name;
  final String lastName;
}

final class FriendsEvent$GetFriendsByName extends FriendEvent {
  const FriendsEvent$GetFriendsByName(this.name) : super();

  final String name;
}

///
abstract base class _$UserEventBase {
  const _$UserEventBase();

  ///
  R map<R>({
    required PatternMatch<R, FriendsEvent$CreateFriend> create,
    required PatternMatch<R, FriendsEvent$LoadAllFriends> loadAllFriends,
    required PatternMatch<R, FriendsEvent$DeleteFriend> deleteFriend,
    required PatternMatch<R, FriendsEvent$UpdateFriend> updateFriend,
    required PatternMatch<R, FriendsEvent$GetFriendsByName> getFriendsByName,
  }) =>
      switch (this) {
        final FriendsEvent$CreateFriend s => create(s),
        final FriendsEvent$LoadAllFriends s => loadAllFriends(s),
        final FriendsEvent$DeleteFriend s => deleteFriend(s),
        final FriendsEvent$UpdateFriend s => updateFriend(s),
        final FriendsEvent$GetFriendsByName s => getFriendsByName(s),
        _ => throw AssertionError(),
      };

  ///
  R maybeMap<R>({
    required R Function() orElse,
    PatternMatch<R, FriendsEvent$CreateFriend>? create,
    PatternMatch<R, FriendsEvent$LoadAllFriends>? loadAllFriends,
    PatternMatch<R, FriendsEvent$DeleteFriend>? deleteFriend,
    PatternMatch<R, FriendsEvent$UpdateFriend>? updateFriend,
    PatternMatch<R, FriendsEvent$GetFriendsByName>? getFriendsByName,
  }) =>
      map<R>(
        create: create ?? (_) => orElse(),
        loadAllFriends: loadAllFriends ?? (_) => orElse(),
        deleteFriend: deleteFriend ?? (_) => orElse(),
        updateFriend: updateFriend ?? (_) => orElse(),
        getFriendsByName: getFriendsByName ?? (_) => orElse(),
      );

  ///
  R? mapOrNull<R>({
    PatternMatch<R, FriendsEvent$CreateFriend>? create,
    PatternMatch<R, FriendsEvent$LoadAllFriends>? loadAllFriends,
    PatternMatch<R, FriendsEvent$DeleteFriend>? deleteFriend,
    PatternMatch<R, FriendsEvent$UpdateFriend>? updateFriend,
    PatternMatch<R, FriendsEvent$GetFriendsByName>? getFriendsByName,
  }) =>
      map<R?>(
        create: create ?? (_) => null,
        loadAllFriends: loadAllFriends ?? (_) => null,
        deleteFriend: deleteFriend ?? (_) => null,
        updateFriend: updateFriend ?? (_) => null,
        getFriendsByName: getFriendsByName ?? (_) => null,
      );
}
