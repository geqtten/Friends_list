import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends_list/feature/home/friends/logic/bloc/friends_bloc.dart';
import 'package:friends_list/feature/home/friends/logic/bloc/friends_event.dart';
import 'package:friends_list/feature/home/friends/logic/bloc/friends_state.dart';
import 'package:friends_list/feature/home/friends/widget/components/friend_card.dart';
import 'package:friends_list/feature/initialization/widget/dependencies_scope.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  late final FriendBloc friendBloc;
  late bool isSearch;

  @override
  void initState() {
    super.initState();
    isSearch = false;
    friendBloc = FriendBloc(
        friendRepository: DependenciesScope.of(context).friendRepository)
      ..add(const FriendEvent.loadAllFriends());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: friendBloc,
        child: Scaffold(
          appBar: AppBar(
            title: !isSearch ? const Text("Friends List") : null,
            backgroundColor: Colors.grey[400],
            actions: [
              if (isSearch) ...[
                const Icon(
                  Icons.person,
                  size: 35,
                ),
                const SizedBox(
                  width: 15,
                ),
                const _Search()
              ],
              IconButton(
                icon: !isSearch
                    ? const Icon(Icons.search)
                    : const Icon(Icons.cancel_outlined),
                onPressed: () {
                  setState(() {
                    isSearch = !isSearch;
                  });
                },
              ),
            ],
          ),
          body: BlocBuilder<FriendBloc, FriendState>(
            builder: (context, state) => Center(
              child: ListView.builder(
                itemCount: state.friends.length,
                itemBuilder: (context, index) => FriendCard(
                  state.friends[index].name,
                  state.friends[index].lastName,
                  state.friends[index].id,
                  friendBloc,
                ),
              ),
            ),
          ),
          floatingActionButton: const CreateCard(),
        ),
      ),
    );
  }
}

class _Search extends StatelessWidget {
  const _Search();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 30,
      width: 300,
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search",
          fillColor: Colors.black12,
          filled: true,
        ),
      ),
    );
  }
}
