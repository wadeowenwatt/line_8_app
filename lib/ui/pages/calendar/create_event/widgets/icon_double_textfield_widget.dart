import 'package:flutter/material.dart';
import 'package:flutter_base/utils/app_date_utils.dart';

class IconDoubleTextField extends StatefulWidget {
  const IconDoubleTextField({
    super.key,
    required this.icon,
    required this.topLabelText,
    required this.bottomLabelText,
    this.onChangedTimeStart,
    this.onChangedTimeStop,
  });

  final Icon icon;
  final String topLabelText;
  final String bottomLabelText;
  final ValueChanged<DateTime>? onChangedTimeStart;
  final ValueChanged<DateTime>? onChangedTimeStop;

  @override
  State<IconDoubleTextField> createState() => _IconDoubleTextFieldState();
}

class _IconDoubleTextFieldState extends State<IconDoubleTextField> {
  var selectedDate = DateTime.now();
  var selectedTime = const TimeOfDay(hour: 9, minute: 0);
  var selectedDateTime = DateTime.now();

  DateTime topDateTime = DateTime.now();

  var textEditingControllerTopField = TextEditingController();
  var textEditingControllerBottomField = TextEditingController();

  _selectDateTime(
      BuildContext context, TextEditingController textEditingController) async {
    final DateTime? datePicker = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2035),
    );

    final timePicker = await showTimePicker(
      initialTime: selectedTime,
      context: context,
    );

    if (datePicker != null && timePicker != null) {
      setState(() {
        selectedDateTime = DateTime(
          datePicker.year,
          datePicker.month,
          datePicker.day,
          timePicker.hour,
          timePicker.minute,
        );
        textEditingController.text = selectedDateTime.toDateTimeString();

        if (textEditingController == textEditingControllerTopField) {
          topDateTime = selectedDateTime;
          textEditingControllerBottomField.text =
              selectedDateTime.toDateTimeString();
        }

        // StartTime is never less than EndTime
        if (textEditingController == textEditingControllerBottomField &&
            topDateTime.compareTo(selectedDateTime) > 0) {
          textEditingControllerTopField.text =
              selectedDateTime.toDateTimeString();
        }

        widget.onChangedTimeStart!(selectedDateTime);
        widget.onChangedTimeStop!(selectedDateTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          readOnly: true,
          controller: textEditingControllerTopField,
          onTap: () => _selectDateTime(
            context,
            textEditingControllerTopField,
          ),
          decoration: InputDecoration(
              icon: widget.icon,
              labelText: widget.topLabelText,
              labelStyle: const TextStyle(color: Colors.grey),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              iconColor: Colors.black),
          style: const TextStyle(color: Colors.black),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: TextField(
            readOnly: true,
            controller: textEditingControllerBottomField,
            onTap: () =>
                _selectDateTime(context, textEditingControllerBottomField),
            decoration: InputDecoration(
                labelText: widget.bottomLabelText,
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                iconColor: Colors.black),
            style: const TextStyle(color: Colors.black),
          ),
        )
      ],
    );
  }
}
