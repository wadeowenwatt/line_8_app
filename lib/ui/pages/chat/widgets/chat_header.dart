import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/models/entities/chat/chat_user_entity.dart';
import 'package:flutter_base/models/entities/user/my_user_entity.dart';
import 'package:flutter_base/ui/widgets/images/app_cache_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key, required this.guest});

  final MyUserEntity guest;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: AppColors.primaryDarkColorLeft,
      child: Container(
        height: 72,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_appbar.png"),
            fit: BoxFit.cover,
          ),
          color: Colors.transparent,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SvgPicture.asset(
                  AppImages.icArrowBack,
                  width: 34,
                  height: 34,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: Colors.white),
              ),
              child: AppCacheImage(
                width: 40,
                height: 40,
                borderRadius: 40,
                fit: BoxFit.fill,
                url: guest.urlAvatar ?? "",
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
                    guest.name ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 27 / 18,
                    ),
                  ),
                  Text(
                    guest.phoneNumber ?? "",
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
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: SvgPicture.asset(
            //     AppImages.icCall,
            //     width: 44,
            //     height: 44,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
