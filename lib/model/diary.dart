import 'package:cloud_firestore/cloud_firestore.dart';

class Diary {
  final String? id;
  final String? userId;
  final String? title;
  final String? author;
  final Timestamp? time;
  final String? photoUrl;
  final String? description;

  Diary(
      {this.id,
      this.userId,
      this.title,
      this.author,
      this.time,
      this.photoUrl,
      this.description});

  factory Diary.fromDocument(QueryDocumentSnapshot data) {
    return Diary(
      id: data.id,
      userId: data.get('user_id'),
      time: data.get('time'),
      photoUrl: data.get('photo_url'),
      author: data.get('author'),
      title: data.get('title'),
      description: data.get('description'),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'time': time,
      'photo_url': photoUrl,
      'author': author,
      'title': title,
      'description': description,
    };
  }
}
