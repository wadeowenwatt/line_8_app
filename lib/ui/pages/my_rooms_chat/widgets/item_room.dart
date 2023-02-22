import 'package:flutter/material.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';

class ItemRoom extends StatelessWidget {
  const ItemRoom({
    Key? key,
    required this.getRoomInfo,
    this.isSeen,
    this.name,
    this.newMessage,
    this.urlAvatar,
  }) : super(key: key);

  final VoidCallback getRoomInfo;
  final bool? isSeen;
  final String? name;
  final String? newMessage;
  final String? urlAvatar;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isSeen == true;
        getRoomInfo();
      },
      child: Card(
        color: AppColors.selectCardColor,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.blue),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: urlAvatar == null
                        ? const AssetImage(AppImages.bgUserPlaceholder)
                        : NetworkImage(urlAvatar as String) as ImageProvider,
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? "",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: (isSeen != null && isSeen!)
                            ? FontWeight.normal
                            : FontWeight.bold),
                  ),
                  Text(
                    newMessage ?? "",
                    style: TextStyle(
                        color: (isSeen != null && isSeen!)
                            ? Colors.grey
                            : Colors.blue,
                        fontWeight: (isSeen != null && isSeen!)
                            ? FontWeight.normal
                            : FontWeight.normal),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
