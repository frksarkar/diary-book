import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/diary.dart';
import '../util/util.dart';
import 'delete_dialog_entry.dart';

class InnerListView extends StatelessWidget {
  const InnerListView({
    super.key,
    required this.element,
    required this.bookCollectionReference,
  });

  final Diary element;
  final CollectionReference<Map<String, dynamic>> bookCollectionReference;

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleTextController =
        TextEditingController(text: element.title);
    final TextEditingController descriptionTextController =
        TextEditingController(text: element.description);
    return AlertDialog(
      title: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Row(
              children: [
                Text(
                  formatDateTimestamp(element.time!),
                  style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.80,
                                height:
                                    MediaQuery.of(context).size.height * 0.80,
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
                                          style: ElevatedButton.styleFrom(
                                              elevation: 4),
                                          child: Text('save'),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 20),
                                                  child: IconButton(
                                                    splashRadius: 20,
                                                    icon:
                                                        const Icon(Icons.image),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                IconButton(
                                                    splashRadius: 20,
                                                    icon: const Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.redAccent,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      deleteDialogEntry(
                                                          context,
                                                          bookCollectionReference,
                                                          element);
                                                    })
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 30,
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(formatDateTimestamp(
                                                        element.time!)),
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.50,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.50,
                                                        child: Image.network(
                                                            element.photoUrl
                                                                .toString())),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                            controller:
                                                                titleTextController,
                                                            decoration:
                                                                const InputDecoration(
                                                                    hintText:
                                                                        'Title...'),
                                                          ),
                                                          TextFormField(
                                                            controller:
                                                                descriptionTextController,
                                                            maxLines: null,
                                                            decoration:
                                                                const InputDecoration(
                                                                    hintText:
                                                                        'Write your thoughts...'),
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
                          });
                    },
                    icon: const Icon(Icons.edit_note)),
                IconButton(
                    icon: const Icon(Icons.delete_forever),
                    onPressed: () {
                      Navigator.of(context).pop();
                      deleteDialogEntry(
                          context, bookCollectionReference, element);
                    })
              ],
            ),
          )
        ],
      ),
      content: ListTile(
        subtitle: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(formatDateFromTimestampHour(element.time)),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.50,
            height: MediaQuery.of(context).size.height * 0.50,
            child: Image.network((element.photoUrl != null)
                ? element.photoUrl.toString()
                : 'https://loremflickr.com/320/240'),
          ),
          Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        element.title.toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        element.description.toString(),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
      actions: [
        TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            })
      ],
    );
  }
}
