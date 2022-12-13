import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/models/entities/chat/chat_message_entity.dart';
import 'package:flutter_base/models/entities/chat/chat_user_entity.dart';
import 'package:flutter_base/ui/commons/app_dialog.dart';
import 'package:flutter_base/ui/widgets/images/app_cache_image.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoMessage extends StatelessWidget {
  final ChatMessageEntity message;
  final ChatUserEntity currentUser;

  const VideoMessage(
      {Key? key, required this.message, required this.currentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isOwnMessage = message.authorId == currentUser.chatUserId;
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: isOwnMessage ? AppColors.orangeAccent : AppColors.greyAccent,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(8),
          topRight: const Radius.circular(8),
          bottomLeft: isOwnMessage ? const Radius.circular(8) : Radius.zero,
          bottomRight: isOwnMessage ? Radius.zero : const Radius.circular(8),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: size.height * 0.3,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(8),
          topRight: const Radius.circular(8),
          bottomLeft: isOwnMessage ? const Radius.circular(8) : Radius.zero,
          bottomRight: isOwnMessage ? Radius.zero : const Radius.circular(8),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AppCacheImage(
              url: message.meta?["thumbnailUrl"] ?? "",
              fit: BoxFit.fill,
            ),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                onPressed: onPlayVideo,
                icon: const Icon(
                  Icons.play_circle_fill_outlined,
                  size: 48,
                  color: AppColors.orangeAccent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onPlayVideo() async {
    try {
      AppDialog.showLoadingDialog();
      final videoPlayerController =
          VideoPlayerController.network(message.meta?["url"] ?? "");

      await videoPlayerController.initialize();

      final chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: true,
      );
      Get.back();
      AppDialog.showVideoDialog(chewieController);
    } catch (error) {
      logger.e(error);
    }
  }
}
