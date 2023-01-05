import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../common/app_images.dart';

class CurrencyTextField extends StatefulWidget {
  const CurrencyTextField({Key? key, required this.moneyCounter})
      : super(key: key);

  final int moneyCounter;

  @override
  State<CurrencyTextField> createState() => _CurrencyTextFieldState();
}

class _CurrencyTextFieldState extends State<CurrencyTextField> {
  late bool _fundVisible;
  late TextEditingController _controller;

  @override
  void initState() {
    _fundVisible = false;
    _controller = TextEditingController(
        text: NumberFormat.simpleCurrency().format(widget.moneyCounter));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      style: const TextStyle(color: Colors.black),
      obscureText: !_fundVisible,
      textAlign: TextAlign.justify,
      obscuringCharacter: "*",
      controller: _controller,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: _fundVisible
              ? Image.asset(AppImages.icEyeClose, height: 20, width: 20,)
              : Image.asset(AppImages.icEyeOpen, height: 20, width: 20,),
          onPressed: () {
            setState(() {
              _fundVisible = !_fundVisible;
            });
          },
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}
