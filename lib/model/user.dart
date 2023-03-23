import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MUser {
  final String? id;
  final String userName;
  final String avatarUrl;
  final String? profession;
  final String uid;

  MUser(
      {required this.userName,
      required this.avatarUrl,
      this.profession,
      required this.uid,
      this.id});

  factory MUser.document(QueryDocumentSnapshot data) {
    return MUser(
        id: data.id,
        userName: data.get('user_name'),
        avatarUrl: data.get('avatar_url'),
        profession: data.get('profession'),
        uid: data.get('uid'));
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'user_name': userName,
      'avatar_url': avatarUrl,
      'profession': profession,
    };
  }
}
