import 'package:flutter/material.dart';
import 'package:flutter_base/utils/app_date_utils.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_text_styles.dart';

class DateField extends StatefulWidget {
  DateField({
    Key? key,
    this.onChanged,
    this.currentValue,
    this.labelText,
    this.highlightText,
    this.textEditingController,
  }) : super(key: key);
  String? currentValue;
  ValueChanged<DateTime>? onChanged;
  String? labelText;
  String? highlightText;
  TextEditingController? textEditingController;

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  var selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    widget.textEditingController = TextEditingController(text: widget.currentValue);
  }

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
        widget.textEditingController?.text = picked.toDateString();
        widget.onChanged!(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: (widget.highlightText != "")
              ? RichText(
            text: TextSpan(children: [
              TextSpan(
                text: widget.labelText,
                style: AppTextStyle.blackS12,
              ),
              TextSpan(
                text: widget.highlightText,
                style: AppTextStyle.blackS12.copyWith(color: Colors.red),
              )
            ]),
          )
              : Text(widget.labelText ?? "", style: AppTextStyle.blackS12),
        ),
        TextField(
          readOnly: true,
          controller: widget.textEditingController,
          style: AppTextStyle.blackS16,
          maxLines: 1,
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.textFieldEnabledBorder),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.textFieldFocusedBorder),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.textFieldDisabledBorder),
            ),
            fillColor: Colors.white,
            isDense: true,
            contentPadding: EdgeInsets.only(top: 8, bottom: 12),
            counterText: "",
          ),
          onTap: () {
            _selectDate(context);
          },
        ),
      ],
    );
  }
}
