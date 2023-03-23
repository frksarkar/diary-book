import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_book/ui/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Network {
  final userCollection = FirebaseFirestore.instance.collection('diaryBook');

  Future<void> getUpdate(userId, name, url) async {
    Map<String, dynamic> updateUser = {'avatar_url': url, 'user_name': name};
    userCollection.doc(userId).update(updateUser);
  }

  Future<void> logout(context) async {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }
}
