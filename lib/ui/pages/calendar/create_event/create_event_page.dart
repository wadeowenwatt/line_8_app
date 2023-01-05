import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/calendar/create_event/widgets/icon_double_textfield_widget.dart';
import 'package:flutter_base/ui/pages/calendar/create_event/widgets/icon_textfield_widget.dart';
import 'package:get/get.dart';

import '../../../../common/app_colors.dart';

class CreateEventPage extends StatelessWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Create Event"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: Container(
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
        height: Get.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                SizedBox(
                  height: AppBar().preferredSize.height +
                      MediaQuery.of(context).padding.top,
                ),
                IconTextField(
                  icon: const Icon(Icons.search),
                  labelText: "Title",
                ),
                const IconDoubleTextField(
                  icon: Icon(Icons.access_time),
                  topLabelText: "Start",
                  bottomLabelText: "End",
                ),
                IconTextField(
                  icon: const Icon(Icons.email),
                  labelText: "Email user create",
                  isEmailInput: true,
                ),
                IconTextField(
                    icon: const Icon(Icons.add_location),
                    labelText: "Location"),
                IconTextField(
                  icon: const Icon(Icons.notifications),
                  labelText: "Set time notification",
                ),
                IconTextField(
                  icon: const Icon(Icons.sticky_note_2_outlined),
                  labelText: "Notes",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
