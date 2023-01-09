import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/ui/pages/list_member/member_profile/widgets/label_text_widget.dart';
import 'package:get/get.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(RouteConfig.editProfile),
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white10),
        child: Column(
          children: [
            Container(
              width: Get.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryLightColorLeft,
                    AppColors.primaryLightColorRight
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      height: AppBar().preferredSize.height +
                          MediaQuery.of(context).padding.top),
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Linh Tran",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text("518"),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    Card(
                      elevation: 3,
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: _buildGeneral(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 3,
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: _buildMore(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneral() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "General",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          LabelText(nameLabel: "Date of birth", text: "4/1/2023"),
          Divider(thickness: 1),
          LabelText(nameLabel: "Profession", text: "Developer"),
          Divider(thickness: 1),
          LabelText(nameLabel: "Employee number", text: "518"),
          Divider(thickness: 1),
          LabelText(nameLabel: "Phone number", text: "0123456789"),
          Divider(thickness: 1),
        ],
      ),
    );
  }

  Widget _buildMore() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "More",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          LabelText(nameLabel: "Email", text: "abc@gmail.com"),
          Divider(thickness: 1),
        ],
      ),
    );
  }
}
