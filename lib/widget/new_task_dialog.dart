import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
