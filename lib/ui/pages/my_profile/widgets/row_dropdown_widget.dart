import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/my_profile/widgets/text_field_custom_widget.dart';
import 'package:flutter_base/ui/widgets/input/app_label_text_field.dart';
import 'package:flutter_base/ui/widgets/input/dropdown_widget.dart';

import '../../../../common/app_text_styles.dart';

class RowDropdownWidget extends StatelessWidget {
  const RowDropdownWidget({
    super.key,
    required this.labelText1,
    required this.dropdownWidget1,
    required this.labelText2,
    required this.dropdownWidget2,
  });

  final String labelText1;
  final DropdownWidget dropdownWidget1;
  final String labelText2;
  final DropdownWidget dropdownWidget2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(labelText1, style: AppTextStyle.blackS12),
                dropdownWidget1,
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(labelText2, style: AppTextStyle.blackS12),
                dropdownWidget2,
              ],
            ),
          )
        ],
      ),
    );
  }
}