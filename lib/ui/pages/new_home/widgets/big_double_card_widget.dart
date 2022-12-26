import 'package:flutter/material.dart';

class BigChoice {
  final String pathImage;
  final String bigText;
  final String smallText;

  const BigChoice(
      {required this.pathImage,
      required this.bigText,
      required this.smallText});
}

class RowTwoBigCardSelection extends StatelessWidget {
  const RowTwoBigCardSelection(
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
