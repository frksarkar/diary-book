import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/diary.dart';
import '../util/util.dart';

StreamBuilder<QuerySnapshot<Map<String, dynamic>>> bodyListView() {
  return StreamBuilder(
    stream: FirebaseFirestore.instance.collection('diaryNotes').snapshots(),
    builder: (BuildContext context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const LinearProgressIndicator();
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
        child: Column(
          children: [
            Expanded(
                child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  var element = filteredList[index];
                  return Card(
                    elevation: 3,
                    child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatDateTimestamp(element.time!),
                              style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                                icon: const Icon(Icons.delete_forever),
                                onPressed: () {})
                          ],
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(formatDateFromTimestampHour(element.time),
                                    style:
                                        const TextStyle(color: Colors.green)),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.more_horiz))
                              ],
                            ),
                            Image.network((element.photoUrl == null)
                                ? "https://loremflickr.com/400/300"
                                : element.photoUrl.toString()),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      element.title.toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      element.description.toString(),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )),
                  );
                },
              ),
            ))
          ],
        ),
      );
    },
  );
}
