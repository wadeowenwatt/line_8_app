import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  const LabelText({
    super.key,
    required this.nameLabel, required this.text,
  });

  final String nameLabel;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          nameLabel,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 5,),
        Text(
          text ?? "",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14
          ),
        )
      ],
    );
  }
}
