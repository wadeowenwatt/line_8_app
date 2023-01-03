import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/ui/pages/list_member/member_profile/widgets/label_text_widget.dart';

class MemberProfilePage extends StatefulWidget {
  const MemberProfilePage({Key? key}) : super(key: key);

  @override
  State<MemberProfilePage> createState() => _MemberProfilePageState();
}

class _MemberProfilePageState extends State<MemberProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text(
              "Profile",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: AppBar().preferredSize.height +
                                MediaQuery.of(context).padding.top),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 80,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Nguyen Tran Thanh Giao Mac Sung Ong",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).viewPadding.top +
                                MediaQuery.of(context).padding.top),
                        const LabelText(nameLabel: "Profession", text: "Developer"),
                        const SizedBox(
                          height: 20,
                        ),
                        const LabelText(nameLabel: "Contact", text: "+84 32323***",),
                        const SizedBox(
                          height: 20,
                        ),
                        const LabelText(nameLabel: "Address", text: "10Vip1",),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  LabelText(nameLabel: "Email", text: "abcxyasdasdasdasz@gmail.com",),
                  SizedBox(height: 20,),
                  LabelText(nameLabel: "Email", text: "abcxyasdasdasdasz@gmail.com",),
                  SizedBox(height: 20,),
                  LabelText(nameLabel: "Email", text: "abcxyasdasdasdasz@gmail.com",),
                  SizedBox(height: 20,),
                  LabelText(nameLabel: "Email", text: "abcxyasdasdasdasz@gmail.com",),
                  SizedBox(height: 20,),
                  LabelText(nameLabel: "Email", text: "abcxyasdasdasdasz@gmail.com",),
                  SizedBox(height: 20,),
                  LabelText(nameLabel: "Email", text: "abcxyasdasdasdasz@gmail.com",),
                  SizedBox(height: 20,),
                  LabelText(nameLabel: "Email", text: "abcxyasdasdasdasz@gmail.com",),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
