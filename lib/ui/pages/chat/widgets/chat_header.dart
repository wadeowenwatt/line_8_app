import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/models/entities/chat/chat_user_entity.dart';
import 'package:flutter_base/ui/widgets/images/app_cache_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key, required this.currentUser});

  final ChatUserEntity currentUser;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset(
              AppImages.icArrowBack,
              width: 34,
              height: 34,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 4, color: AppColors.orangeAccent),
            ),
            child: AppCacheImage(
              width: 40,
              height: 40,
              borderRadius: 40,
              fit: BoxFit.fill,
              url: currentUser.avatarUrl,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${currentUser.firstName} ${currentUser.lastName}",
                  style: const TextStyle(
                    color: AppColors.orangeAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 27 / 18,
                  ),
                ),
                Text(
                  "+${currentUser.phoneCode} ${currentUser.phone}",
                  style: const TextStyle(
                    color: AppColors.blackAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 18 / 12,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset(
              AppImages.icCall,
              width: 44,
              height: 44,
            ),
          )
        ],
      ),
    );
  }
}
