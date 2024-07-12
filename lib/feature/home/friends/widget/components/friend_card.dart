import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:friends_list/feature/home/friends/logic/bloc/friends_bloc.dart';
import 'package:friends_list/feature/home/friends/logic/bloc/friends_event.dart';
import 'package:friends_list/feature/home/friends/widget/components/add_dialog.dart';
import 'package:friends_list/feature/home/friends/widget/components/rename_dialog.dart';
import 'package:friends_list/feature/initialization/widget/dependencies_scope.dart';

// ignore: must_be_immutable
class FriendCard extends StatefulWidget {
  const FriendCard(
    this.name,
    this.lastName,
    this.id,
    this.friendBloc, {
    super.key,
  });

  final String name;
  final String lastName;
  final int id;
  final FriendBloc friendBloc;

  @override
  State<FriendCard> createState() => _FriendCardState();
}

class _FriendCardState extends State<FriendCard> {
  late final TextEditingController renameNameController;
  late final TextEditingController renameLastNameController;

  @override
  void initState() {
    super.initState();
    renameLastNameController = TextEditingController();
    renameNameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            renameDialog(
              context,
              renameNameController,
              renameLastNameController,
              widget.id,
              widget.friendBloc,
            );
          } else if (direction == DismissDirection.endToStart) {
            widget.friendBloc.add(
              FriendEvent.deleteFriend(widget.id),
            );
          }
        },
        child: Card(
          child: ListTile(
            title: Text(
              "${widget.name} ${widget.lastName}",
              style: const TextStyle(fontSize: 25),
            ),
            leading: const Icon(
              Icons.person,
              size: 35,
            ),
          ),
        ),
      );
}

class CreateCard extends StatefulWidget {
  const CreateCard({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _CreateCardState createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateCard> {
  late TextEditingController nameController;
  late TextEditingController lastNameController;
  late final FriendBloc friendBloc;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    lastNameController = TextEditingController();
    friendBloc = FriendBloc(
        friendRepository: DependenciesScope.of(context).friendRepository);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return ElevatedButton(
      onPressed: () {
        return dialogBuilder(
            context, nameController, lastNameController, friendBloc);
      },
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          iconColor: Colors.grey[300]),
      child: const Text(
        "+",
        style: TextStyle(fontSize: 30, color: Colors.black87),
      ),
    );
  }
}
