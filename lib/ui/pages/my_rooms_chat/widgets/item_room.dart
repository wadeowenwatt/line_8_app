import 'package:flutter/material.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';

class ItemRoom extends StatelessWidget {
  const ItemRoom({
    Key? key,
    required this.getRoomInfo,
    this.name,
    this.newMessage,
    this.urlAvatar,
  }) : super(key: key);

  final VoidCallback getRoomInfo;
  final String? name;
  final String? newMessage;
  final String? urlAvatar;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: getRoomInfo,
      child: Card(
        color: AppColors.selectCardColor,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: urlAvatar == null
                    ? const AssetImage(AppImages.bgUserPlaceholder)
                    : NetworkImage(urlAvatar as String) as ImageProvider,
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? "",
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    newMessage ?? "",
                    style: const TextStyle(color: Colors.grey),
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
