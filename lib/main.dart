import 'package:diary_book/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'ui/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diary Book',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.green,
      ),
      home: const LoginPage(),
    );
  }
}

// class GetData extends StatelessWidget {
//   const GetData({super.key});
//   @override
//   Widget build(BuildContext context) {
//     var firebaseDb = FirebaseFirestore.instance.collection('diaryBook');

//     return Scaffold(
//       body: StreamBuilder(
//           stream: firebaseDb.snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return const Text('something was wrong');
//             }
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Text('loading...');
//             }
//             print(snapshot.data!.docs[0]['title']);
//             return ListView.builder(
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                       title: Text(snapshot.data!.docs[index]['author']),
//                       subtitle: Text(snapshot.data!.docs[index]['title']));
//                 });
//           }),
//     );
//   }
// }
