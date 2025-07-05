import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';

class ReportInput extends StatelessWidget {
  ReportInput({
    Key? key,
    required this.label,
    this.highlightText = "",
    this.errorText = "",
    this.validation = false,
    this.onChanged,
  }) : super(key: key);

  final String label;
  String highlightText;
  String errorText;
  final ValueChanged<String>? onChanged;
  bool validation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                  text: label, style: const TextStyle(color: Colors.black)),
              TextSpan(
                  text: highlightText,
                  style: const TextStyle(color: Colors.red))
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        TextFormField(
          onChanged: onChanged,
          style: const TextStyle(color: Colors.black),
          validator: (value) {
            if (validation) {
              if (value == null || value.isEmpty) {
                return errorText;
              } else {
                return null;
              }
            }
            return null;
          },
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryLightColorLeft),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          keyboardType: TextInputType.multiline,
          minLines: 3,
          maxLines: 3,
        ),
      ],
    );
  }
}
