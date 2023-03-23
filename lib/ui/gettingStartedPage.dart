import 'package:flutter/material.dart';

import 'login_page.dart';

class GettingStartedPage extends StatelessWidget {
  const GettingStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CircleAvatar(
        backgroundColor: Colors.blueGrey.shade50,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'Diary Book.',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.08),
            child: const Text('"Document your life!"',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blueGrey,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                )),
          ),
          TextButton.icon(
            icon: const Icon(Icons.login),
            label: const Text('Sing in to get start',
                style: TextStyle(fontSize: 20)),
            style: TextButton.styleFrom(
                backgroundColor: Colors.amber.shade200,
                padding: const EdgeInsets.all(16.0)),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          )
        ]),
      ),
    );
  }
}
