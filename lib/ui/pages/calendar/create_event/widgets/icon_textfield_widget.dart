import 'package:flutter/material.dart';

class IconTextField extends StatelessWidget {

  IconTextField({
    super.key,
    required this.icon,
    required this.labelText,
    this.isEmailInput = false,
  });

  final Icon icon;
  final String labelText;
  bool isEmailInput = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType:
          isEmailInput ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
          icon: icon,
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white70),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          iconColor: Colors.white),
      style: const TextStyle(color: Colors.white),
    );
  }
}
