import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends_list/feature/home/friends/data/friend_repository.dart';

import 'friends_event.dart';
import 'friends_state.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  FriendBloc({required this.friendRepository})
      : super(const FriendState.idle()) {
    on<FriendEvent>(
      (event, emit) => event.map(
        create: (e) => _createFriend(e, emit),
        loadAllFriends: (e) => _loadAllFriends(e, emit),
        deleteFriend: (e) => _deleteFriend(e, emit),
        updateFriend: (e) => _updateFriend(e, emit),
        getFriendsByName: (e) => _getFriendsByName(e, emit),
      ),
    );
  }

  final FriendRepository friendRepository;

  Future<void> _createFriend(
      FriendsEvent$CreateFriend event, Emitter<FriendState> emit) async {
    try {
      final newFriend = await friendRepository.createFriend(
        name: event.name,
        lastName: event.lastName,
      );
      final allFriend = await friendRepository.getAllFriends();
      emit(FriendState.loaded(
        friends: allFriend,
        friend: newFriend,
      ));
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

  Future<void> _updateFriend(
      FriendsEvent$UpdateFriend event, Emitter<FriendState> emit) async {
    try {
      await friendRepository.updateFriend(
        name: event.name,
        lastName: event.lastName,
        id: event.id,
      );
      final allFriend = await friendRepository.getAllFriends();
      emit(FriendState.loaded(
        friends: allFriend,
        // friend: updateFriend,
      ));

      {
        await friendRepository.updateFriend(
          name: event.name,
          lastName: event.lastName,
          id: event.id,
        );
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

  Future<void> _getFriendsByName(
      FriendsEvent$GetFriendsByName event, Emitter<FriendState> emit) async {
    try {
      final result = await friendRepository.getFriendsByName(event.name);

      emit(FriendState.loaded(
        friends: result,
      ));
    } on Object catch (e) {
      emit(
        FriendState.idle(
          error: e.toString(),
        ),
      );
    }
  }
}
