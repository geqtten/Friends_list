import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends_list/feature/home/friends/logic/bloc/friends_bloc.dart';
import 'package:friends_list/feature/home/friends/logic/bloc/friends_event.dart';
import 'package:friends_list/feature/home/friends/logic/bloc/friends_state.dart';
import 'package:friends_list/feature/home/friends/widget/components/create_card.dart';
import 'package:friends_list/feature/initialization/widget/dependencies_scope.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return MaterialApp(
      home: BlocProvider.value(
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
                itemBuilder: (context, index) => Dismissible(
                  onDismissed: (direction) => friendBloc.add(
                    FriendEvent.deleteFriend(state.friends[index].id),
                  ),
                  key: UniqueKey(),
                  child: FriendCard(
                      state.friends[index].name, state.friends[index].lastName),
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
