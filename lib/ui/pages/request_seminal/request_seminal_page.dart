import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/widgets/input/dropdown_widget.dart';
import 'package:flutter_base/ui/widgets/buttons/app_tint_button.dart';
import 'package:flutter_base/utils/app_date_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/app_colors.dart';
import '../../widgets/input/date_field_input.dart';

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
          DateField(),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Details:",
            style: TextStyle(color: Colors.grey),
          ),
          const TextField(
            style: TextStyle(color: Colors.black),
          ),
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
