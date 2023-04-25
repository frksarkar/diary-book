import 'package:diary_book/ui/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'input_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required GlobalKey<FormState>? globalKey,
    required TextEditingController emailTextController,
    required TextEditingController passwordTextController,
  })  : _globalKey = globalKey,
        _emailTextController = emailTextController,
        _passwordTextController = passwordTextController;

  final GlobalKey<FormState>? _globalKey;
  final TextEditingController _emailTextController;
  final TextEditingController _passwordTextController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Log in',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: createInputField(
            validate: (value) {
              return value.isEmpty ? 'Please enter an email' : null;
            },
            context: context,
            hint: 'jhon@exapled.com',
            label: 'Email',
            value: false,
            control: _emailTextController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, bottom: 18.0, right: 18.0),
          child: createInputField(
            validate: (value) {
              return value.isEmpty ? 'please enter a password' : null;
            },
            context: context,
            label: 'Password',
            value: true,
            control: _passwordTextController,
          ),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 18)),
            child: const Text('Login'),
            onPressed: () {
              if (_globalKey!.currentState!.validate()) {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                    .then((value) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MainPage()));
                });
              }
            }),
      ]),
    );
  }
}
