import 'package:flutter/material.dart';
import 'package:friends_list/feature/home/friends/logic/bloc/friends_bloc.dart';
import 'package:friends_list/feature/home/friends/logic/bloc/friends_event.dart';

class SearchFriends extends StatelessWidget {
  final FriendBloc friendBloc;
  const SearchFriends(this.friendBloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 300,
      child: TextField(
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Search",
          fillColor: Colors.black12,
          filled: true,
        ),
        onChanged: (value) {
          friendBloc.add(FriendEvent.getFriendsByName(value));
        },
      ),
    );
  }
}
