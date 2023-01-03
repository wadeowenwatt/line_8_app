import 'package:flutter/material.dart';

import '../../../../common/app_colors.dart';

class Choice {
  final String title;
  final String pathImage;
  final String pathScreen;
  bool isLogout = false;

  Choice({
    required this.title,
    required this.pathImage,
    required this.pathScreen,
    this.isLogout = false,
  });
}

class RowTwoCardSelection extends StatelessWidget {
  const RowTwoCardSelection({
    Key? key,
    required this.choice1,
    this.choice2,
    required this.onClick1,
    required this.onClick2,
  }) : super(key: key);
  final Choice choice1;
  final Choice? choice2;
  final VoidCallback onClick1;
  final VoidCallback onClick2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 130,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: onClick1,
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
                      Image.asset(
                        choice1.pathImage,
                        height: 45,
                        width: 40,
                        fit: BoxFit.fill,
                      ),
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
        ),
        Expanded(
          child: SizedBox(
            height: 130,
            child: choice2 == null
                ? const SizedBox()
                : InkWell(
                    onTap: onClick2,
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
                            Image.asset(
                              choice2!.pathImage,
                              height: 45,
                              width: 40,
                              fit: BoxFit.fill,
                            ),
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
        ),
      ],
    );
  }
}
