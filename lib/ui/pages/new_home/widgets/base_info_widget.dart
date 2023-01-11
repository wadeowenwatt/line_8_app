import 'package:flutter/material.dart';
import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';

class InformationWidget extends StatefulWidget {
  const InformationWidget({
    Key? key,
    required this.onClick,
    this.name = "",
    this.department = "",
    this.employeeNumber = "000",
    this.position = "Unknown",
  }) : super(key: key);

  final VoidCallback onClick;
  final String name;
  final String department;
  final String employeeNumber;
  final String position;

  @override
  State<InformationWidget> createState() => _InformationWidgetState();
}

class _InformationWidgetState extends State<InformationWidget> {
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
              Text(widget.name,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  )),
              Row(
                children: [
                  Text(widget.department),
                  const Text(" | "),
                  Text("Employee Number: ${widget.employeeNumber}"),
                ],
              ),
              Card(
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Text(
                      widget.position,
                      style: const TextStyle(color: AppColors.primaryLightColorLeft),
                    )),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          GestureDetector(
            onTap: widget.onClick,
            child: const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(AppImages.bgUserPlaceholder),
            ),
          ),
        ],
      ),
    );
  }
}
