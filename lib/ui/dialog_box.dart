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
                ElevatedButton(
                    onPressed: () {
                      Network().getUpdate(
                          user.id, nameValue.text, profileUrlValue.text);
                      Future.delayed(Duration(milliseconds: 400), () {
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text('UPDATE')),
              ]),
        ),
      );
    },
  );
}

Future<dynamic> addNewTaskDialogBox(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.80,
            height: MediaQuery.of(context).size.height * 0.80,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text('Discard'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Done'),
                      style: ElevatedButton.styleFrom(elevation: 4),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.image_rounded),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('24/08/2070'),
                          SizedBox(
                              width: (MediaQuery.of(context).size.height * 0.8),
                              child: Form(
                                  child: Column(
                                children: [
                                  SizedBox(
                                      height:
                                          (MediaQuery.of(context).size.height *
                                                  0.8) /
                                              2,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.amber,
                                        child: Text('image here'),
                                      )),
                                  TextFormField(
                                    decoration:
                                        InputDecoration(hintText: 'Title...'),
                                  ),
                                  TextFormField(
                                    maxLines: null,
                                    decoration: InputDecoration(
                                        hintText: 'Write your thoughts...'),
                                  ),
                                ],
                              )))
                        ],
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
}
