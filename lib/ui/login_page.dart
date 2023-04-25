import 'package:flutter/material.dart';

import '../widget/login_from.dart';
import '../widget/sign_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool isCreatedAccountClicked = false;

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    isCreatedAccountClicked
                        ? CreateAccount(
                            globalKey: _globalKey,
                            emailTextController: _emailTextController,
                            passwordTextController: _passwordTextController)
                        : LoginForm(
                            globalKey: _globalKey,
                            emailTextController: _emailTextController,
                            passwordTextController: _passwordTextController),
                    const Spacer(),
                    TextButton.icon(
                        icon: const Icon(Icons.account_circle),
                        label: Text(isCreatedAccountClicked
                            ? 'Already have an account?'
                            : 'Create Account'),
                        onPressed: () {
                          setState(() {
                            if (!isCreatedAccountClicked) {
                              isCreatedAccountClicked = true;
                            } else {
                              isCreatedAccountClicked = false;
                            }
                          });
                        })
                  ],
                ),
              )),
            ),
          ])),
    );
  }
}
