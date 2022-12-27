import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/new_home/widgets/base_info_widget.dart';
import 'package:flutter_base/ui/pages/new_home/widgets/big_double_card_widget.dart';
import 'package:flutter_base/ui/pages/new_home/widgets/double_card_widget.dart';

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
  Choice(title: "2", pathImage: "assets/images/img.png"),
  Choice(title: "3", pathImage: "assets/images/img_1.png"),
  Choice(title: "4", pathImage: "assets/images/img_2.png"),
  Choice(title: "5", pathImage: "assets/images/img_3.png"),
  Choice(title: "6", pathImage: "assets/images/img_4.png"),
  Choice(title: "7", pathImage: "assets/images/img_5.png"),
  Choice(title: "8", pathImage: "assets/images/img_6.png"),
  Choice(title: "9", pathImage: "assets/images/img_7.png"),
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
                            : choices[index * 2 + 1]);
                  },
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  itemCount: (choices.length / 2).round(),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

}