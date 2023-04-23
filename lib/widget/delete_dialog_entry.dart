import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/diary.dart';

Future<dynamic> deleteDialogEntry(
    BuildContext context,
    CollectionReference<Map<String, dynamic>> bookCollectionReference,
    Diary element) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'Delete Entry?',
          style: TextStyle(color: Colors.red),
        ),
        content: const Text(
            'Are you sure you want to delete this entry?\nthis action can\'t be reversed. '),
        actions: [
          TextButton(
            child: const Text('cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('delete'),
            onPressed: () {
              bookCollectionReference
                  .doc(element.id)
                  .delete()
                  .then((value) => Navigator.of(context).pop());
            },
          )
        ],
      );
    },
  );
}
