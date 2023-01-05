import 'package:flutter/material.dart';
import '../../../../common/app_colors.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({Key? key, required this.onClick})
      : super(key: key);

  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
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
          GestureDetector(
            onTap: onClick,
            child: const CircleAvatar(
              radius: 30,
              backgroundImage:
                  AssetImage("assets/images/bg_image_placeholder.png"),
            ),
          ),
        ],
      ),
    );
  }
}
