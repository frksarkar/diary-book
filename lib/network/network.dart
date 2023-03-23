import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user.dart';

class Network {
  final userCollection = FirebaseFirestore.instance.collection('diaryBook');

  Future<void> getUpdate(userId, name, url) async {
    MUser updateUser = MUser(userName: name, avatarUrl: url, uid: userId);
    userCollection.doc(userId).update(updateUser.toMap());
  }
}
