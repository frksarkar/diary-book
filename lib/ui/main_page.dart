import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_book/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../network/network.dart';
import 'dialog_box.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _dropdownButtonText = 'Select';

  @override
  Widget build(BuildContext context) {
    final titleTextController = TextEditingController();
    final descriptionTextController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          toolbarHeight: 100,
          elevation: 4,
          title: Row(children: [
            Text('Diary', style: TextStyle(color: Colors.blueGrey.shade400)),
            Text('Book', style: TextStyle(color: Colors.green.shade400))
          ]),
          actions: [
            Row(children: [
              DropdownButton(
                items: ['Latest', 'Earliest'].map((value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
                hint: Text(_dropdownButtonText),
                onChanged: (value) {
                  if (value == 'Latest') {
                    setState(() {
                      _dropdownButtonText = value.toString();
                    });
                  } else if (value == 'Earliest') {
                    setState(() {
                      _dropdownButtonText = value.toString();
                    });
                  }
                },
              ),
              //TODO: create profile
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('diaryBook')
                      .snapshots(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    final curUser = snapshot.data!.docs.map((user) {
                      return MUser.document(user);
                    }).where((element) {
                      return element.uid ==
                          FirebaseAuth.instance.currentUser!.uid;
                    }).first;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0),
                                child: InkWell(
                                  onTap: () {
                                    dialogBox(context, curUser);
                                  },
                                  child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          NetworkImage(curUser.avatarUrl),
                                      radius: 30),
                                ),
                              ),
                              Text(curUser.userName,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 18))
                            ]),
                        IconButton(
                            icon: const Icon(Icons.logout, color: Colors.red),
                            onPressed: () {
                              Network().logout(context);
                            })
                      ]),
                    );
                  }))
            ])
          ]),
      body: Row(children: [
        Expanded(
            child: Container(
                width: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Colors.blueGrey, width: 0.5))),
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SfDateRangePicker(
                        onSelectionChanged:
                            (dateRangePickerSelectionChangedArgs) {},
                      )),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Card(
                        elevation: 4,
                        child: TextButton.icon(
                          icon: const Icon(Icons.add,
                              size: 35, color: Colors.greenAccent),
                          label: Row(
                            children: const [
                              Text('Write New', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return NewTaskDialog(
                                      titleTextController: titleTextController,
                                      descriptionTextController:
                                          descriptionTextController);
                                });
                          },
                        )),
                  )
                ]))),
        Expanded(flex: 3, child: Container(color: Colors.white))
      ]),
      floatingActionButton: FloatingActionButton(
          tooltip: 'Add', onPressed: () {}, child: const Icon(Icons.add)),
    );
  }
}

class NewTaskDialog extends StatefulWidget {
  const NewTaskDialog({
    super.key,
    required this.titleTextController,
    required this.descriptionTextController,
  });

  final TextEditingController titleTextController;
  final TextEditingController descriptionTextController;

  @override
  State<NewTaskDialog> createState() => _NewTaskDialogState();
}

class _NewTaskDialogState extends State<NewTaskDialog> {
  var btnText = 'Done';

  @override
  Widget build(BuildContext context) {
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
                  style: ElevatedButton.styleFrom(elevation: 4),
                  child: Text(btnText),
                  onPressed: () {
                    setState(() {
                      btnText = 'saving...';
                    });
                    Future.delayed(const Duration(milliseconds: 2500))
                        .then((value) => Navigator.of(context).pop());
                    FirebaseFirestore.instance.collection('diaryNotes').add({
                      'title': widget.titleTextController.text,
                      'description': widget.descriptionTextController.text,
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
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
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('24/08/2070'),
                      SizedBox(
                          width: (MediaQuery.of(context).size.height * 0.8),
                          child: Form(
                              child: Column(
                            children: [
                              SizedBox(
                                  height: (MediaQuery.of(context).size.height *
                                          0.8) /
                                      2,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.amber,
                                    child: const Text('image here'),
                                  )),
                              TextFormField(
                                controller: widget.titleTextController,
                                decoration:
                                    const InputDecoration(hintText: 'Title...'),
                              ),
                              TextFormField(
                                controller: widget.descriptionTextController,
                                maxLines: null,
                                decoration: const InputDecoration(
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
  }
}
