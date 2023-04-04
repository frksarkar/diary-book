import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import '../network/network.dart';
import '../ui/dialog_box.dart';

class NavBarProfile extends StatelessWidget {
  const NavBarProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('diaryBook').snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          final curUser = snapshot.data!.docs.map((user) {
            return MUser.document(user);
          }).where((element) {
            return element.uid == FirebaseAuth.instance.currentUser!.uid;
          }).first;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: InkWell(
                    onTap: () {
                      dialogBox(context, curUser);
                    },
                    child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(curUser.avatarUrl),
                        radius: 30),
                  ),
                ),
                Text(curUser.userName,
                    style: const TextStyle(color: Colors.grey, fontSize: 18))
              ]),
              IconButton(
                  icon: const Icon(Icons.logout, color: Colors.red),
                  onPressed: () {
                    Network().logout(context);
                  })
            ]),
          );
        }));
  }
}
