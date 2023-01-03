import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/request_seminal/widgets/dropdown_widget.dart';
import 'package:flutter_base/ui/widgets/buttons/app_tint_button.dart';
import 'package:flutter_base/utils/app_date_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/app_colors.dart';

class RequestSeminalPage extends StatelessWidget {
  const RequestSeminalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Request Seminal"),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryLightColorLeft,
                AppColors.primaryLightColorRight
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: AppBar().preferredSize.height +
                    MediaQuery.of(context).padding.top),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: buildBody(),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Name:",
            style: TextStyle(color: Colors.grey),
          ),
          const DropdownWidget(
            nameList: ["", "linhtn1", "asdasd", "asdasdasd"],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Title:",
            style: TextStyle(color: Colors.grey),
          ),
          const TextField(
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Time:",
            style: TextStyle(color: Colors.grey),
          ),
          const DateField(),
          const SizedBox(
            height: 30,
          ),
          AppTintButton(title: "Send", onPressed: _sendRequest),
        ],
      ),
    );
  }

  void _sendRequest() {
    /// Todo
  }
}

class DateField extends StatefulWidget {
  const DateField({Key? key}) : super(key: key);

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
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        textEditingController.text = picked.toDateString();
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
