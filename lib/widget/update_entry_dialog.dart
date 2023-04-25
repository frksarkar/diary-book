import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../model/diary.dart';
import '../util/util.dart';
import 'delete_dialog_entry.dart';

class UpdateEntryDialog extends StatefulWidget {
  const UpdateEntryDialog(
      {super.key,
      required this.element,
      required this.bookCollectionReference});
  final Diary element;
  final CollectionReference<Map<String, dynamic>> bookCollectionReference;

  @override
  State<UpdateEntryDialog> createState() => _UpdateEntryDialogState();
}

class _UpdateEntryDialogState extends State<UpdateEntryDialog> {
  var _fileBytes;
  Image? _imageWidget;
  @override
  Widget build(BuildContext context) {
    final TextEditingController titleTextController =
        TextEditingController(text: widget.element.title);
    final TextEditingController descriptionTextController =
        TextEditingController(text: widget.element.description);
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.80,
        height: MediaQuery.of(context).size.height * 0.80,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    child: const Text('Discard'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 4),
                  child: const Text('update'),
                  onPressed: () {
                    final userIdRef =
                        widget.bookCollectionReference.doc(widget.element.id);
                    final fs = FirebaseStorage.instance.ref();
                    DateTime time = DateTime.now();
                    final path = '${time.millisecondsSinceEpoch}';

                    if (titleTextController.text != widget.element.title ||
                        descriptionTextController.text !=
                            widget.element.description ||
                        _fileBytes != null) {
                      Future.delayed(
                        const Duration(milliseconds: 1500),
                        () {
                          Navigator.of(context).pop();
                        },
                      );
                      userIdRef.update({
                        'title': titleTextController.text,
                        'description': descriptionTextController.text
                      });

                      // image store in firebase
                      final meteData =
                          SettableMetadata(contentType: 'image/jpeg');
                      fs
                          .child(
                              'images/$path${FirebaseAuth.instance.currentUser!.uid}')
                          .putData(_fileBytes, meteData)
                          .then((value) {
                        value.ref.getDownloadURL().then((value) {
                          userIdRef.update({'photo_url': value.toString()});
                          return null;
                        });
                        return null;
                      });
                      // // Create a reference to the file to delete
                      // final desertRef = fs.child(
                      //     'images/1682425358381${FirebaseAuth.instance.currentUser!.uid}');

                      // // Delete the file
                      // desertRef.delete();
                    }
                  },
                ),
              ],
            ),
            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: IconButton(
                            splashRadius: 20,
                            icon: const Icon(Icons.image),
                            onPressed: () async {
                              await getMultipleImageInfos();
                            },
                          ),
                        ),
                        IconButton(
                            splashRadius: 20,
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              deleteDialogEntry(context, (value) {
                                if (value) {
                                  int count = 2;
                                  Navigator.of(context)
                                      .popUntil((_) => count-- <= 0);
                                }
                              }, widget.bookCollectionReference,
                                  widget.element);
                            })
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(formatDateTimestamp(widget.element.time!)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.50,
                                height:
                                    MediaQuery.of(context).size.height * 0.50,
                                child: (_imageWidget != null)
                                    ? _imageWidget
                                    : Image.network(
                                        widget.element.photoUrl.toString())),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: titleTextController,
                                    decoration: const InputDecoration(
                                        hintText: 'Title...'),
                                  ),
                                  TextFormField(
                                    controller: descriptionTextController,
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                        hintText: 'Write your thoughts...'),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ))
                  ],
                ))
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
