import 'dart:html' as html;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_book/model/diary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';

class NewTaskDialog extends StatefulWidget {
  const NewTaskDialog({
    super.key,
    this.selectedDate,
    required this.titleTextController,
    required this.descriptionTextController,
  });

  final DateTime? selectedDate;
  final TextEditingController titleTextController;
  final TextEditingController descriptionTextController;

  @override
  State<NewTaskDialog> createState() => _NewTaskDialogState();
}

class _NewTaskDialogState extends State<NewTaskDialog> {
  var btnText = 'Done';
  CollectionReference diaryCollection =
      FirebaseFirestore.instance.collection('diaryNotes');
  html.File? _cloudFile;
  var _fileBytes;
  Image? _imageWidget;

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
                    firebase_storage.FirebaseStorage fs =
                        firebase_storage.FirebaseStorage.instance;
                    DateTime dateTime = DateTime.now();
                    final path = '$dateTime';
                    String? currId;

                    final fieldNotEmpty =
                        widget.titleTextController.text.isNotEmpty &&
                            widget.descriptionTextController.text.isNotEmpty;
                    if (fieldNotEmpty) {
                      setState(() {
                        btnText = 'saving...';
                      });
                      Future.delayed(const Duration(milliseconds: 2500))
                          .then((value) => Navigator.of(context).pop());
                      diaryCollection
                          .add(Diary(
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        time: Timestamp.fromDate(widget.selectedDate!),
                        author: FirebaseAuth.instance.currentUser!.email!
                            .split('@')
                            .first,
                        title: widget.titleTextController.text,
                        description: widget.descriptionTextController.text,
                      ).toMap())
                          .then((value) {
                        setState(() {
                          currId = value.id;
                        });
                        return null;
                      });
                    }

                    if (_fileBytes != null) {
                      firebase_storage.SettableMetadata metaData =
                          firebase_storage.SettableMetadata(
                              contentType: 'image/jpeg',
                              customMetadata: {'picked-file-path': path});

                      fs
                          .ref()
                          .child(
                              'images/$path${FirebaseAuth.instance.currentUser!.uid}')
                          .putData(_fileBytes, metaData)
                          .then((value) {
                        value.ref.getDownloadURL().then((value) {
                          diaryCollection
                              .doc(currId)
                              .update({'photo_url': value.toString()});
                          return null;
                        });
                        return null;
                      });
                    }
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
                          onPressed: () {
                            getMultipleImageInfos();
                          },
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
                      Text(DateFormat.yMMMd().format(widget.selectedDate!)),
                      SizedBox(
                          width: (MediaQuery.of(context).size.height * 0.8),
                          child: Form(
                              child: Column(
                            children: [
                              SizedBox(
                                  height: (MediaQuery.of(context).size.height *
                                          0.8) /
                                      2,
                                  child: (_imageWidget != null)
                                      ? _imageWidget
                                      : const Center(
                                          child: Text(
                                            'Image Preview',
                                            style: TextStyle(fontSize: 25),
                                          ),
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

  Future<void> getMultipleImageInfos() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    // String mimeType = mime(Path.basename(mediaData!.fileName!))!;
    // html.File mediaFile =
    //     html.File(mediaData.data!, mediaData.fileName!, {'type': mimeType});

    // if (mediaFile != null) {
    setState(() {
      // _cloudFile = mediaFile;
      _fileBytes = mediaData!.data;
      _imageWidget = Image.memory(mediaData.data!);
    });
    // }
  }
}
