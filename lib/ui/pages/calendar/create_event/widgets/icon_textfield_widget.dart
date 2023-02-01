import 'package:flutter/material.dart';

class IconTextField extends StatelessWidget {
  IconTextField({
    super.key,
    required this.icon,
    required this.labelText,
    this.isEmailInput = false,
    this.onChanged,
  });

  final Icon icon;
  final String labelText;
  final ValueChanged<String>? onChanged;
  bool isEmailInput = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType:
          isEmailInput ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
          icon: icon,
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.grey),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          iconColor: Colors.black),
      style: const TextStyle(color: Colors.black),
      onChanged: onChanged,
    );
  }
}
