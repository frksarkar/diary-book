import 'package:flutter/material.dart';

TextFormField createInputField(
    {required BuildContext context,
    required String label,
    String? hint,
    required bool value,
    required control}) {
  return TextFormField(
    obscureText: value,
    controller: control,
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
