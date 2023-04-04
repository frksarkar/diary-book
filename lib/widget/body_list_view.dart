import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/diary.dart';

StreamBuilder<QuerySnapshot<Map<String, dynamic>>> bodyListView() {
  return StreamBuilder(
    stream: FirebaseFirestore.instance.collection('diaryNotes').snapshots(),
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      }
      var filteredList = snapshot.data!.docs
          .map((e) {
            return Diary.fromDocument(e);
          })
          .where((element) =>
              element.userId == FirebaseAuth.instance.currentUser!.uid)
          .toList();
      return Expanded(
        flex: 3,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    child: ListTile(
                      title: Text(filteredList[index].title.toString()),
                    ),
                  );
                },
              ))
            ],
          ),
        ),
      );
    },
  );
}
