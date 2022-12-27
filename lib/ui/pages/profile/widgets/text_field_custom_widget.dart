import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    super.key,
    required this.labelText,
    required this.haveSuffixIcon,
  });

  final String labelText;
  final bool haveSuffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: labelText,
        suffixIcon: haveSuffixIcon
            ? Image.asset(
          "assets/images/ic_suffix_textfield.png",
        )
            : null,
      ),
    );
  }
}