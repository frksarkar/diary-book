import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailTextController;
  final TextEditingController _passwordTextController;
  final GlobalKey<FormState>? _globalKey;

  const LoginPage({
    super.key,
    required emailController,
    required passwordController,
    GlobalKey<FormState>? globalKey,
  })  : _emailTextController = emailController,
        _passwordTextController = passwordController,
        _globalKey = globalKey;

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
                child: Form(
                  key: _globalKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Log in',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: createInputField(
                            context: context,
                            hint: 'jhon@exapled.com',
                            label: 'Email',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 18.0, bottom: 18.0, right: 18.0),
                          child: createInputField(
                            context: context,
                            label: 'Password',
                          ),
                        ),
                        ElevatedButton(
                            child: const Text('Create account'),
                            onPressed: () {})
                      ]),
                ),
              )),
            ),
          ])),
    );
  }

  TextFormField createInputField(
      {required BuildContext context, required String label, String? hint}) {
    return TextFormField(
      controller: _emailTextController,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: Colors.grey, width: 1.5)),
          label: Text(label),
          hintText: hint),
    );
  }
}
