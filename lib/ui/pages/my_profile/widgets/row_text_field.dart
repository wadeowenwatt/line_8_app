import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/my_profile/widgets/text_field_custom_widget.dart';

class RowTextField extends StatelessWidget {
  const RowTextField({
    super.key,
    required this.textField1,
    required this.textField2,
  });

  final TextFieldCustom textField1;
  final TextFieldCustom textField2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17),
      child: Row(
        children: [
          Expanded(
              child: textField1
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: textField2
          )
        ],
      ),
    );
  }
}