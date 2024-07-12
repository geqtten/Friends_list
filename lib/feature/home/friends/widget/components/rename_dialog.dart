import 'package:flutter/material.dart';
import 'package:friends_list/feature/home/friends/logic/bloc/friends_bloc.dart';
import 'package:friends_list/feature/home/friends/logic/bloc/friends_event.dart';

void renameDialog(
        BuildContext context,
        TextEditingController renameNameController,
        TextEditingController renameLastNameController,
        int id,
        FriendBloc friendBloc) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Rename friend",
          style: TextStyle(fontSize: 22),
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          height: 166,
          child: Column(
            children: [
              TextFormField(
                controller: renameNameController,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), hintText: "Enter name"),
              ),
              TextFormField(
                controller: renameLastNameController,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), hintText: "Enter lastname"),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 6),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                      height: 45,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        friendBloc.add(FriendEvent.updateFriend(
                          renameNameController.text,
                          renameLastNameController.text,
                          id,
                        ));
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Confirm",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
