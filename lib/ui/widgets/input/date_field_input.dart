import 'package:flutter/material.dart';
import 'package:flutter_base/utils/app_date_utils.dart';

class DateField extends StatefulWidget {
  DateField({Key? key, this.onChanged}) : super(key: key);

  ValueChanged<DateTime>? onChanged;

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  var selectedDate = DateTime.now();
  var textEditingController = TextEditingController();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        textEditingController.text = picked.toDateString();
        widget.onChanged!(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: textEditingController,
      style: const TextStyle(color: Colors.black),
      onTap: () {
        _selectDate(context);
      },
    );
  }
}