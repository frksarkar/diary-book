import 'package:diary_book/model/user.dart';
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
                Text('Edit your profile', style: TextStyle(fontSize: 20)),
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
                ElevatedButton(onPressed: () {}, child: Text('UPDATE')),
              ]),
        ),
      );
    },
  );
}
