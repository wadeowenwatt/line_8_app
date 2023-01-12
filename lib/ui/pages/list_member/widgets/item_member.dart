import 'package:flutter/material.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_images.dart';

class ItemMember extends StatelessWidget {
  const ItemMember({
    Key? key,
    required this.getMemberInfo,
    this.name,
    this.position,
    this.urlAvatar,
  }) : super(key: key);
  final VoidCallback getMemberInfo;
  final String? name;
  final String? position;
  final String? urlAvatar;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: getMemberInfo,
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
                    position ?? "",
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
