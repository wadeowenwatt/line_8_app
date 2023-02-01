import 'package:flutter/material.dart';

import '../../../../common/app_images.dart';
import '../../team_fund/widgets/currency_textfield.dart';

class BigChoice {
  final String pathImage;
  String bigText;
  String smallText;
  String pathScreen;

  BigChoice({
    required this.pathImage,
    this.bigText = "",
    this.smallText = "",
    this.pathScreen = "",
  });
}

class RowTwoBigCardSelection extends StatelessWidget {
  const RowTwoBigCardSelection({
    Key? key,
    required this.choice1,
    required this.choice2,
    required this.onClick1,
    required this.onClick2,
  }) : super(key: key);
  final BigChoice choice1;
  final BigChoice choice2;
  final VoidCallback onClick1;
  final VoidCallback onClick2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 200,
            child: InkWell(
              onTap: onClick1,
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
                            fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 200,
            child: InkWell(
              onTap: onClick2,
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
                            fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
