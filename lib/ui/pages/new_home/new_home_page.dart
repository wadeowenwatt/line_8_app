import 'package:flutter/material.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/ui/pages/new_home/widgets/base_info_widget.dart';
import 'package:flutter_base/ui/pages/new_home/widgets/big_double_card_widget.dart';
import 'package:flutter_base/ui/pages/new_home/widgets/double_card_widget.dart';
import 'package:get/get.dart';

import '../../../common/app_colors.dart';

part 'method.dart';

const List choices = [
  BigChoice(
      pathImage: "assets/images/ic_fake_1.png",
      bigText: "89.69%",
      smallText: "Attendance"),
  BigChoice(
      pathImage: "assets/images/ic_fake_2.png",
      bigText: "300\$",
      smallText: "Amount"),
  Choice(title: "Wiki", pathImage: "assets/images/img.png", pathScreen: RouteConfig.wiki),
  Choice(title: "3", pathImage: "assets/images/img_1.png", pathScreen: ""),
  Choice(title: "4", pathImage: "assets/images/img_2.png", pathScreen: ""),
  Choice(title: "5", pathImage: "assets/images/img_3.png", pathScreen: ""),
  Choice(title: "6", pathImage: "assets/images/img_4.png", pathScreen: ""),
  Choice(title: "7", pathImage: "assets/images/img_5.png", pathScreen: ""),
  Choice(title: "8", pathImage: "assets/images/img_6.png", pathScreen: ""),
  Choice(title: "9", pathImage: "assets/images/img_7.png", pathScreen: ""),
];

class NewHomePage extends StatelessWidget {
  const NewHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              AppColors.primaryDarkColorLeft,
              AppColors.primaryLightColorRight
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Column(
          children: [
            const InformationWidget(),
            Expanded(
              child: Stack(children: [
                backgroundCard(),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return RowTwoBigCardSelection(
                          choice1: choices[index], choice2: choices[index + 1]);
                    }
                    return RowTwoCardSelection(
                      choice1: choices[index * 2],
                      choice2: (index * 2 + 1) >= choices.length
                          ? null
                          : choices[index * 2 + 1],
                      onClick1: () {
                        _onClick1((choices[index * 2] as Choice).pathScreen);
                      },
                      onClick2: () {
                        (index * 2 + 1) >= choices.length ? {} :
                        _onClick2(
                            (choices[index * 2 + 1] as Choice).pathScreen);
                      },
                    );
                  },
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  itemCount: (choices.length / 2).round(),
                )
              ],),
            ),
          ],
        ),
      ),
    );
  }

  void _onClick1(String path) {
    if (path != "") Get.toNamed(path);
  }

  void _onClick2(String path) {
    /// Todo
  }
}
