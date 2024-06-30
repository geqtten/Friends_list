import 'package:flutter/material.dart';
import 'package:friends_list/feature/home/friends/logic/bloc/friends_bloc.dart';
import 'package:friends_list/feature/home/friends/widget/components/show_dialog.dart';
import 'package:friends_list/feature/initialization/widget/dependencies_scope.dart';

// ignore: must_be_immutable
class FriendCard extends StatelessWidget {
  late String name;
  late String lastName;

  FriendCard(this.name, this.lastName, {super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          "$name $lastName",
          style: const TextStyle(fontSize: 25),
        ),
        leading: const Icon(
          Icons.person,
          size: 35,
        ),
        onTap: () {},
      ),
    );
  }
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
