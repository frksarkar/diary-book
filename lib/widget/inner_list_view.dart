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
