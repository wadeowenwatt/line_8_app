import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';

class NewHomePage extends StatelessWidget {
  const NewHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heightOfScreen = MediaQuery.of(context).size.height;
    final widthOfScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          AppColors.primaryDarkColorLeft,
          AppColors.primaryLightColorRight
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Column(
          children: [
            informationWidget(),
            Expanded(
              child: Stack(children: [
                backgroundCard(),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return BigSelectCardRow(
                          choice1: choices[index], choice2: choices[index + 1]);
                    }
                    return SelectCardRow(
                        choice1: choices[index * 2],
                        choice2: (index * 2 + 1) >= choices.length ? null : choices[index * 2 + 1]
                    );
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

  Widget informationWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 100, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Linh Tran",
                  style: TextStyle(
                    fontSize: 30,
                  )),
              Row(
                children: const [
                  Text("Class XI B"),
                  Text(" | "),
                  Text("Rolls no: 04"),
                ],
              ),
              const Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Text(
                      "2022 - 2023",
                      style: TextStyle(color: AppColors.primaryLightColorLeft),
                    )),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          const CircleAvatar(
            radius: 30,
            backgroundImage:
                AssetImage("assets/images/bg_image_placeholder.png"),
          ),
        ],
      ),
    );
  }

  Widget backgroundCard() {
    return Column(
      children: [
        const SizedBox(
          height: 120,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            ),
          ),
        ),
      ],
    );
  }
}

class Choice {
  final String title;
  final String pathImage;

  const Choice({required this.title, required this.pathImage});
}

class BigChoice {
  final String pathImage;
  final String bigText;
  final String smallText;

  const BigChoice(
      {required this.pathImage,
      required this.bigText,
      required this.smallText});
}

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
  Choice(title: "3", pathImage: "assets/images/img.png"),
  Choice(title: "4", pathImage: "assets/images/img_1.png"),
  Choice(title: "5", pathImage: "assets/images/img_2.png"),
  Choice(title: "6", pathImage: "assets/images/img_3.png"),
  Choice(title: "7", pathImage: "assets/images/img_4.png"),
  Choice(title: "8", pathImage: "assets/images/img_5.png"),
  Choice(title: "9", pathImage: "assets/images/img_6.png"),
  Choice(title: "10", pathImage: "assets/images/img_7.png"),
  Choice(title: "11", pathImage: "assets/images/img_6.png"),
  Choice(title: "12", pathImage: "assets/images/img_7.png"),
];

class BigSelectCardRow extends StatelessWidget {
  const BigSelectCardRow(
      {Key? key, required this.choice1, required this.choice2})
      : super(key: key);
  final BigChoice choice1;
  final BigChoice choice2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 200,
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  side: BorderSide(color: Colors.blue)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(choice1.pathImage),
                    Text(
                      choice1.bigText,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    ),
                    Text(
                      choice1.smallText,
                      style: const TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 200,
            child: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  side: BorderSide(color: Colors.blue)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(choice2.pathImage),
                    Text(
                      choice2.bigText,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    ),
                    Text(
                      choice2.smallText,
                      style: const TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SelectCardRow extends StatelessWidget {
  const SelectCardRow({Key? key, required this.choice1, this.choice2})
      : super(key: key);
  final Choice choice1;
  final Choice? choice2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 130,
            child: Card(
              color: AppColors.selectCardColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(choice1.pathImage),
                    Text(
                      choice1.title,
                      style: const TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 130,
            child: choice2 == null
                ? const SizedBox()
                : Card(
                    color: AppColors.selectCardColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(choice2!.pathImage),
                          Text(
                            choice2!.title,
                            style: const TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
