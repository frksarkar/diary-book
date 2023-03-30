import 'package:diary_book/model/user.dart';
import 'package:diary_book/network/network.dart';
import 'package:diary_book/widget/input_field.dart';
import 'package:flutter/material.dart';

Future<dynamic> dialogBox(BuildContext context, MUser user) {
  final nameValue = TextEditingController(text: user.userName);
  final profileUrlValue = TextEditingController(text: user.avatarUrl);
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.50,
          height: MediaQuery.of(context).size.height * 0.50,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Edit your profile', style: TextStyle(fontSize: 20)),
                createInputField(
                    context: context,
                    label: 'name',
                    value: false,
                    control: nameValue),
                createInputField(
                    context: context,
                    label: 'url',
                    value: false,
                    control: profileUrlValue),
                ElevatedButton(
                    onPressed: () {
                      Network().getUpdate(
                          user.id, nameValue.text, profileUrlValue.text);
                      Future.delayed(const Duration(milliseconds: 400), () {
                        Navigator.of(context).pop();
                      });
                    },
                    child: const Text('UPDATE')),
              ]),
        ),
      );
    },
  );
}
