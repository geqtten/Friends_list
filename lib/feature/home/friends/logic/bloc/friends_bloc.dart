import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends_list/feature/home/friends/data/friend_repository.dart';

import 'friends_event.dart';
import 'friends_state.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  FriendBloc({required this.friendRepository})
      : super(const FriendState.idle()) {
    on<FriendEvent>(
      (event, emit) => event.map(
        create: (e) => _create(e, emit),
        loadAllFriends: (e) => _loadAllFriends(e, emit),
        deleteFriend: (e) => _deleteFriend(e, emit),
      ),
    );
  }

  final FriendRepository friendRepository;

  Future<void> _create(
      FriendEvent$Create event, Emitter<FriendState> emit) async {
    try {
      final newFriend = await friendRepository.create(
        name: event.name,
        lastName: event.lastName,
      );
      final allFriend = await friendRepository.getAllFriends();
      emit(FriendState.loaded(friends: allFriend, friend: newFriend));
    } on Object catch (e) {
      emit(
        FriendState.idle(error: e.toString()),
      );
    }
  }

  Future<void> _loadAllFriends(
      FriendEvent event, Emitter<FriendState> emit) async {
    try {
      {
        final allFriends = await friendRepository.getAllFriends();
        emit(FriendState.loaded(
          friends: allFriends,
        ));
      }
    } on Object catch (e) {
      emit(
        FriendState.idle(
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> _deleteFriend(
      FriendsEvent$DeleteFriend event, Emitter<FriendState> emit) async {
    try {
      {
        await friendRepository.deleteFriend(event.id);
        _loadAllFriends;
      }
    } on Object catch (e) {
      emit(
        FriendState.idle(
          error: e.toString(),
        ),
      );
    }
  }
}
