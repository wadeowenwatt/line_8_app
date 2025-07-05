import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/app_images.dart';

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
            ? SvgPicture.asset(
                AppImages.icLock,
                fit: BoxFit.none,
              )
            : null,
      ),
    );
  }
}
