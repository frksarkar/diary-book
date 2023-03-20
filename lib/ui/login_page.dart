import 'package:flutter/material.dart';

import '../widget/login_from.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          color: Colors.blueGrey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              width: 400,
              height: 500,
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: LoginForm(
                    globalKey: _globalKey,
                    emailTextController: _emailTextController,
                    passwordTextController: _passwordTextController),
              )),
            ),
          ])),
    );
  }
}
